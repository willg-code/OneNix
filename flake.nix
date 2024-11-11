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
  };

  outputs =
    { ... }@inputs:
    let
      lib = import ./lib;
      modules = import ./modules;
      machines = import ./machines modules.machines;
      users = import ./users modules.users;
      homes = import ./homes modules.homes;

      overlays = [ ];
      mkSystems = lib.mkSystems {
        inherit inputs overlays modules;
      };
    in
    {
      nixosConfigurations = mkSystems
        {
          andromeda = {
            machineConfig = machines.andromeda;
            users = {
              willg = {
                userConfig = users.willg;
                homeConfig = homes.island;
              };
            };
          };
        };
    };
}
