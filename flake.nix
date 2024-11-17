{
  description = "OneNix dotfiles";

  inputs = {
    # Nixpkgs (using unstable to approximate rolling releases)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Secret Management
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Cool Cutting Edge Browser
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib // (import ./lib inputs.nixpkgs.lib); # join local lib with nixpkgs lib
      modules = import ./modules lib; # construct the modules for the configurations
      machines = import ./machines lib modules.machines; # import machine specific configs
      users = import ./users lib modules.users; # import user specific configs
      homes = import ./homes lib modules.homes; # import home specific configs

      overlays = [ ]; # override nixpkgs packages
      mkSystems = lib.mkSystems { inherit inputs overlays; }; # construct our mkSystems function
    in
    {
      nixosConfigurations = mkSystems
        {
          andromeda = {
            machineConfig = machines.andromeda;
            users = {
              willg = {
                user = users.willg;
                home = homes.island;
              };
            };
          };
        };
    };
}
