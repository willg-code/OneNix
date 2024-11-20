### DESC ###
# Given overlays, output a nixpkgs.lib.nixosSystem
# with those overlays. Also imports all necessary
# modules for extra behavior (e.g home-manager, sops, etc).
#
# Input looks like this (called "builds"):
# {
#   <hostname> = {
#     machineConfig = <machine config>;
#     users = {
#       <username> = {
#         user = <user config>;
#         home = <home config>; (optional)
#       };
#       ... (more users)
#     };
#     optimize-store = true; (optional)
#   };
# }
#
# Alows four points of flexibility:
# - Each machine config can be deployed to multiple differently-named computers if they have the same hardware
# - Each machine config is abstracted from the users provided to it, allowing users to be added and removed at-will.
# - Each user and home are identified by an arbitrary username, ensuring the accounts can be renamed if necessary
# - Each user has a home, configured independently of the user itself, so homes can be swapped around at-will.

### ARGS ###
lib:
{ inputs, overlays, modules }:

let
  home-manager = inputs.home-manager.nixosModules.home-manager;
  sops-nix = inputs.sops-nix.nixosModules.sops;
in

builds:
lib.mapAttrs
  (hostname: { machineConfig, users, optimize-store ? true }:
  let
    specialArgs = { inherit inputs hostname; };
  in
  lib.nixosSystem {
    inherit lib specialArgs;
    modules = [
      modules.machines # local machine modules
      modules.users # local user modules
      home-manager
      sops-nix
      machineConfig
      # Global Configuration
      {
        nixpkgs.overlays = overlays;
        nix = {
          registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs; # Use the system flake registry, map all inputs
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs; # Update nix path to refer to the system registry for legacy compatability
          channel.enable = false;
          settings = {
            experimental-features = [ "nix-command" "flakes" ]; # Enable flakes
            flake-registry = ""; # Disable global flake registry
            auto-optimise-store = optimize-store; # Enable store optimization on every build
          };
          optimise = {
            automatic = optimize-store; # Enable automatic store optimization
            dates = [ "daily" ]; # Run optimizer daily
          };
        };
        # Global HM Config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
      }
    ] ++
    # User configurations.
    (lib.concatLists
      (lib.attrValues
        (lib.mapAttrs
          (username: { user, home ? null }:
            let
              # An object to pass to the home manager modules
              identity = {
                inherit username;
                name = user.name;
                email = user.email;
              };
            in
            [ (user.config username) ] ++ # import the user config, and...
              # Check if a home config is provided (it might not be for system users)
              lib.optionals (home != null) [
                # User specific global config
                {
                  home-manager.users.${username} = {
                    programs.home-manager.enable = true; # let HM control itself
                    home.username = username; # set the username at the home level
                    home.homeDirectory = "/home/${username}"; # indicate which directory contains the home
                  };
                }
                # Needs to be separate because it might be a module
                {
                  home-manager.users.${username} = (home identity);
                }
                {
                  home-manager.users.${username} = modules.homes; # local home modules
                }
              ]
          )
          users
        )
      )
    );
  })
  builds
