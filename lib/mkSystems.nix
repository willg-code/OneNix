lib:
# This function creates NixOS system 
# configurations with custom config.
{ inputs, overlays }:

let
  specialArgs = { inherit inputs; };
  home-manager = inputs.home-manager.nixosModules.home-manager;
  sops-nix = inputs.sops-nix.nixosModules.sops;
in
builds:
builtins.mapAttrs
  (name: { machineConfig, users, optimize-store ? true, gc ? true }:
  lib.nixosSystem {
    specialArgs = specialArgs;
    modules = [
      home-manager # Import home manager
      sops-nix # Import sops-nix
      (machineConfig name) # Apply the machine configuration.
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
        home-manager.extraSpecialArgs = specialArgs;
      }
    ] ++
    # User configurations.
    (builtins.concatLists
      (builtins.attrValues
        (builtins.mapAttrs
          (username: { user, home ? null }:
            let
              identity = {
                inherit username;
                name = user.name;
                email = user.email;
              };
            in
            [
              # Import the user config.
              (user.config username)
            ] ++
            # Check if a home config is provided (it might not be for system users)
            lib.optionals (!builtins.isNull home) [
              # Import the home config.
              {
                home-manager.users.${username} = {
                  programs.home-manager.enable = true;
                  home.username = username;
                  home.homeDirectory = "/home/${username}";
                };
              }
              # Needs to be separate because it might be a module
              {
                home-manager.users.${username} = (home identity);
              }
            ]
          )
          users
        )
      )
    );
  })
  builds
