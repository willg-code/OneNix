{
  description = "OneNix dotfiles";

  inputs = {
    # Nixpkgs (using unstable to approximate rolling releases)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
      lib = inputs.nixpkgs.lib // (import ./lib inputs.nixpkgs.lib);
      modules = import ./modules lib;
      machines = import ./machines lib modules.machines;
      users = import ./users lib modules.users;
      homes = import ./homes lib modules.homes;

      overlays = [ ];
      mkSystems = lib.mkSystems { inherit inputs overlays; };
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
