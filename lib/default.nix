lib: {
  getContents = import ./getContents.nix lib;
  listDir = import ./listDir.nix lib;
  mkModuleDir = import ./mkModuleDir.nix lib;
  mkSystems = import ./mkSystems.nix lib;
}
