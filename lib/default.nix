lib:

{
  getContents = import ./getContents.nix lib;
  importDir = import ./importDir.nix lib;
  importDirWithArgs = import ./importDirWithArgs.nix lib;
  mkModuleDir = import ./mkModuleDir.nix lib;
  mkSystems = import ./mkSystems.nix lib;
}
