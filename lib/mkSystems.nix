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
#         home = <home config>; (optional [e.g. system users])
#       };
#       ... (more users)
#     };
#     optimize-store = true; (optional)
#     gc = true; (optional)
#   };
# }
#
# Alows four points of flexibility:
# - Each machine config can be deployed to multiple differently-named computers if they have the same hardware
# - Each machine config is abstracted from the users provided to it, allowing users to be added and removed at-will.
# - Each user and home are identified by an arbitrary username, ensuring the accounts can be renamed if necessary
# - Each user has a home, configured independently of the user itself, so homes can be swapped around at-will.

### ARGS ###
lib: # Necessary for some behavior
{ inputs, overlays }: # Flake inputs and nixpkgs overlays

let
  home-manager = inputs.home-manager.nixosModules.home-manager; # home manager module
  sops-nix = inputs.sops-nix.nixosModules.sops; # sops nix module
in
builds: # input object, see DESC
builtins.mapAttrs # process each config
  (hostname: { machineConfig, users, optimize-store ? true, gc ? true }:
  let
    specialArgs = { inherit inputs hostname; }; # special arguments to be passed into the modules
  in
  lib.nixosSystem {
    inherit specialArgs; # pass special args to modules
    modules = [
      home-manager # import home manager
      sops-nix # import sops-nix
      machineConfig # apply the machine configuration.
      # Global Configuration
      {
        nixpkgs.overlays = overlays; # Apply overlays
        nix = {
          registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs; # Use the system flake registry, map all inputs
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs; # Update nix path to refer to the system registry for legacy compatability
          channel.enable = false; # Disable channels
          settings = {
            experimental-features = [ "nix-command" "flakes" ]; # Enable flakes
            flake-registry = ""; # Disable global flake registry
            auto-optimise-store = optimize-store; # Enable store optimization on every build
          };
          gc = {
            automatic = gc; # Enable automatic garbage collection.
            dates = "daily"; # Run garbage collection daily
            options = "--delete-older-than 10d"; # Delete store paths older than 10 days
          };
          optimise = {
            automatic = optimize-store; # Enable automatic store optimization
            dates = [ "daily" ]; # Run optimizer daily
          };
        };
        # Global HM Config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs; # pass special args to home manager modules
      }
    ] ++
    # User configurations.
    (builtins.concatLists
      (builtins.attrValues
        (builtins.mapAttrs
          (username: { user, home ? null }:
            let
              # An object to pass to the home manager modules
              # to paramaterize who the config is for
              identity = {
                inherit username;
                name = user.name;
                email = user.email;
              };
            in
            [ (user.config username) ] ++ # import the user config, and...
              # Check if a home config is provided (it might not be for system users)
              lib.optionals (!builtins.isNull home) [
                # User specific global config
                {
                  home-manager.users.${username} = {
                    programs.home-manager.enable = true; # let HM control itself
                    home.username = username; # set the username at the home level
                    home.homeDirectory = "/home/${username}"; # indicate which directory contains the home
                  };
                }
                # Needs to be separate because it might be a module 
                # (thus must be processed before being merged)
                {
                  home-manager.users.${username} = (home identity);
                }
              ]
          )
          users # map inputted user objects
        )
      )
    );
  })
  builds # map inputted build objects
