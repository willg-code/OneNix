# This function creates NixOS system configurations with custom config.
# Based on mitchellh's dotfiles.
{ inputs, overlays, modules }:

let
  nixos = inputs.nixpkgs.lib.nixosSystem;
  home-manager = inputs.home-manager.nixosModules.home-manager;
  nixpkgs = inputs.nixpkgs;
in
builds:
  builtins.mapAttrs
    (name: { system, machineConfig, users, unfree ? false, optimize-store ? true, gc ? true }:
      nixos {
        inherit system;

        modules = [
          {
            # Global Options
            options.current = { 
              system = mkOption {
                type = types.str;
                default = system;
              };
              name = mkOption {
                type = types.str;
                default = name;
              };
            };
            config = {
              nixpkgs = {
                overlays = overlays; # Apply overlays.
                config.allowUnfree = unfree; # Allow unfree packages to build.
              };
              nix = {
                registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs; # Use the system flake registry, map all in.
                nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs; # Update nix path to refer to the system registry for legacy compatability.
                channel.enable = false; # Disable channels.
                settings = {
                  experimental-features = [ "nix-command" "flakes" ]; # Enable flakes
                  flake-registry = ""; # Disable global flake registry.
                  auto-optimize-store = optimize-store; # Enable store optimization on every build.
                };
                nix.gc = {
                  automatic = gc; # Enable automatic garbage collection.
                  dates = "daily"; # Run garbage collection weekly.
                  options = "--delete-older-than 10d"; # Delete store paths older than 30 days.
                }
              };
            };
          }
          machineConfig # Apply the machine configuration.
        ] ++ builtins.attrValues # Apply the user configurations.
              (builtins.mapAttrs 
                (username: { userConfig, homeConfig }:
                  [
                    # Import the user config.
                    (userConfig username)
                    # Import the home config.
                    (home-manager {
                      # Global HM Config
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users.${name} = homeConfig username;
                    })
                  ]
                )
                users
              )
      }
    )
    builds