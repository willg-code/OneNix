### DESC ###
# Constructs a list with the absolute paths of
# every file in the directory, intended for modules.
# 
# NOTE: does not grab default.nix

lib:
path:

(lib.map (lib.path.append path) lib.getContents)
