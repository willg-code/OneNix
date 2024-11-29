{
  description = "OneNix dotfiles";

  ##! INPUTS CAN BE FOUND AFTER OUTPUTS !##

  outputs = {...} @ inputs: let
    lib = inputs.nixpkgs.lib.extend (final: prev: (import ./lib final)); # extend nixpkgs.lib with local lib
    impl = path: import path lib; # construct a function to import with lib
    mkSystems = lib.mkSystems {inherit inputs;}; # construct mkSystems function

    overlays = [];
    homes = impl ./homes; # import home specific configs
    machines = impl ./machines; # import machine specific configs
    modules = impl ./modules; # import modules
    users = impl ./users; # import user specific configs
  in {
    overlays = import ./overlays {inherit inputs;};
    secrets = impl ./secrets;
    nixosModules.default = modules.nixos;
    homeManagerModules.default = modules.home-manager;
    nixosConfigurations = mkSystems [
      {
        machine = machines.andromeda;
        users = [
          {
            user = users.willg;
            home = homes.moon;
          }
        ];
      }
    ];
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
