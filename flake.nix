{
  description = "OneNix dotfiles";

  ##! INPUTS CAN BE FOUND AFTER OUTPUTS !##

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib.extend (final: prev: (import ./lib final)); # extend nixpkgs.lib with local lib
      impl = (path: import path lib); # construct a function to import with lib

      overlays = [ ]; # override nixpkgs packages
      modules = impl ./modules; # import the modules for the configurations
      machines = impl ./machines; # import machine specific configs
      users = impl ./users; # import user specific configs
      homes = impl ./homes; # import home specific configs
      secrets = import ./secrets; # sops secrets

      mkSystems = lib.mkSystems { inherit inputs overlays modules secrets; }; # construct our mkSystems function
    in
    {
      nixosConfigurations = mkSystems {
        andromeda = {
          machineConfig = machines.andromeda;
          users = [
            {
              user = users.willg;
              home = homes.island;
            }
          ];
        };
      };
    };

  inputs = {
    # Nixpkgs (using unstable to approximate rolling releases)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secret Management
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Cool Cutting Edge Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Unified Styles
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";
  };
}
