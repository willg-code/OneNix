lib:

{
  getContents = import ./getContents.nix lib;
  importDir = import ./importDir.nix lib;
  listDir = import ./listDir.nix lib;
  mkSystems = import ./mkSystems.nix lib;
}
