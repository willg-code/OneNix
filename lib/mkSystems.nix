# This function creates NixOS system configurations with custom config.
# Based on mitchellh's dotfiles.
{ inputs, overlays, modules }:

let
  nixos = inputs.nixpkgs.lib.nixosSystem;
  home-manager = inputs.home-manager.nixosModules.home-manager;
  sops-nix = inputs.sops-nix.nixosModules.sops;
  nixpkgs = inputs.nixpkgs;
  lib = inputs.lib;
in
builds:
builtins.mapAttrs
  (name: { machineConfig, users, optimize-store ? true, gc ? true }:
  nixos {
    system = null; # To set system modularly
    modules = [
      home-manager # Import home manager
      sops-nix # Import sops-nix
      (machineConfig name) # Apply the machine configuration.
      # Global Configuration
      {
        nixpkgs = {
          overlays = overlays; # Apply overlays.
        };
        nix = {
          registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs; # Use the system flake registry, map all in.
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs; # Update nix path to refer to the system registry for legacy compatability.
          channel.enable = false; # Disable channels.
          settings = {
            experimental-features = [ "nix-command" "flakes" ]; # Enable flakes
            flake-registry = ""; # Disable global flake registry.
            auto-optimize-store = optimize-store; # Enable store optimization on every build.
          };
          gc = {
            automatic = gc; # Enable automatic garbage collection.
            dates = "daily"; # Run garbage collection weekly.
            options = "--delete-older-than 10d"; # Delete store paths older than 30 days.
          };
        };
        environment.systemPackages = [
          pkgs.ssh-to-age # Required for SOPS-nix using SSH identities
        ];
        # Global HM Config
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ] ++
    # User configurations.
    (builtins.concatLists
      (builtins.attrValues
        (builtins.mapAttrs
          (username: { userConfig, homeConfig }:
            [
              # Import the user config.
              (userConfig username)
              # Import the home config.
              { home-manager.users.${username} = (homeConfig username); }
              {
                home-manager.users.${username} = {
                  programs.home-manager.enable = true;
                  home = {
                    username = username;
                    homeDirectory = "/home/${username}";
                  };
                };
              }
            ]
          )
          users
        )
      )
    );
  })
  builds
