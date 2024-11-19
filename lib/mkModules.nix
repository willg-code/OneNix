### DESC ###
# Constructs a set of the following structure
#
# {
#   imports = [ <every file in path> ];
# }
# 
# (with the exception of default.nix)

lib:
path:

let
  # get the names of all of the files/directories in the directory 
  # (except for default.nix)
  contents =
    (builtins.attrNames
      (lib.filterAttrs
        (name: type: name != "default.nix")
        (builtins.readDir path)));

  # append the path to the name of everything in the directory
  # so that imports can read it properly
  files = (builtins.map (lib.path.append path) contents);
in
{
  imports = files;
}
