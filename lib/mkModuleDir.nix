### DESC ###
# Constructs an import statement with the absolute paths of
# every file in the directory, intended for modules.
#
# NOTE: does not import default.nix
lib: path: {
  imports = lib.map (lib.path.append path) (lib.getContents path);
}
