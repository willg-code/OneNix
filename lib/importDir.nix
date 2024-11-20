### DESC ###
# Constructs a set containing an import of every file
# found on the given path, of the form
#
# {
#   <filename> = import <filename>;
# }
#
# NOTE: For sake of convenience, the ".nix"
#       is stripped from the names with ".nix" 
#       at the end
#
#       example.nix -> example

### INTERNAL HELPER FUNCTIONS ###
let
  # function to concatenate all but the last
  # element from a list of strings with a "."
  concatAllButLast =
    lst:
    if (builtins.length lst) == 1
    then ""
    else (builtins.head lst) + "." + (concatAllButLast (builtins.tail lst));

  # function to strip ". nix" from the
  # end of names of files and folders
  formatName =
    name:
    let
      # split the name at each "."
      nameParts =
        (builtins.filter
          (i: !builtins.isList i)
          (builtins.split ''\.'' name));
    in
    # if the file type is ".nix"
    if (builtins.elemAt nameParts ((builtins.length nameParts) - 1)) == "nix"
    # then take everything but the type (substring removes the extra ".")
    then let stripped = concatAllButLast nameParts; in (builtins.substring 0 ((builtins.stringLength stripped) - 1) stripped)
    # otherwise give the name as-is
    else name;
in

### ARGS ###
lib: # required for some behaviors
path: # path to import

let
  # get the names of all of the
  # files/directories in the directory 
  # (except for default.nix)
  contents =
    (lib.attrNames
      (lib.filterAttrs
        (name: type: name != "default.nix")
        (builtins.readDir path)));
  # set each name equal to 
  # its imported path
  attributes =
    (lib.map
      (content:
        {
          name = formatName content;
          value = import (lib.path.append path content);
        })
      contents);
in
# Finally, turn all of the attribute pieces into a set
lib.listToAttrs attributes
