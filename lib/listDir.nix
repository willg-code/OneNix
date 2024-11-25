### DESC ###
# Constructs a set containing the name of every file
# found on the given path, of the form
#
# {
#   <filename> = /path/to/<filename>;
# }

lib:
path:

let
  attributes =
    (lib.map
      (content:
        {
          name = content;
          value = lib.path.append path content;
        })
      (lib.getContents path));
in
lib.listToAttrs attributes
