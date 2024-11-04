{
  description = "OneNix dotfiles";

  inputs = {
    # Nixpkgs (using unstable to approximate rolling releases)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { ... }@inputs:
    let
      lib = import ./lib;
      modules = import ./modules;
      machines = import ./machines modules;
      users = import ./users modules;
      homes = import ./homes modules;

      overlays = [ ];
      mkSystems = import lib.mkSystems {
        inherit inputs overlays modules;
      };
    in
    {
      nixosConfigurations = mkSystems {
        andromeda = {
          system = "x86_64-linux";
          machineConfig = machines.andromeda;
          users = {
            williamg = {
              userConfig = users.williamg;
              homeConfig = homes.acolyte;
            }
          };
        };
      }
    };
}
