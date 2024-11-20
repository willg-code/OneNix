lib:

{
  importDir = import ./importDir.nix lib;
  mkModules = import ./mkModules.nix lib;
  mkSystems = import ./mkSystems.nix lib;
}
