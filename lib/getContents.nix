### DESC ###
# Constructs a list containing all files and directories
# on the target path, except for default.nix

lib:
path:

(lib.attrNames
  (lib.filterAttrs
    (name: type: (type == "directory") || (name != "default.nix"))
    (builtins.readDir path)))
