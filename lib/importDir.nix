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

lib:
path:

let
  # set each name equal to 
  # its imported path
  attributes =
    (lib.map
      (content:
        {
          name = content;
          value = import (lib.path.append path content);
        })
      (lib.getContents path));
in
# Finally, turn all of the attribute pieces into a set
lib.listToAttrs attributes
