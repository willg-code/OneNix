lib:
path:

let
  # get the names of all of the
  # files/directories in the directory 
  # (except for default.nix)
  contents =
    (builtins.attrNames
      (lib.filterAttrs
        (name: type: name != "default.nix")
        (builtins.readDir path)));
  # function to strip ". nix" from the
  # names of files (and folders if applicable)
  formatName =
    (name:
      let
        # split the name at the "."
        nameParts =
          (builtins.filter
            (i: !builtins.isList i)
            (builtins.split ''\.'' name));
      in
      # if the file type is ".nix"
      if (builtins.length nameParts) == 2 && (builtins.elemAt nameParts 1) == "nix"
      # then take everything but the type
      then (builtins.elemAt nameParts 0)
      # otherwise give the name as-is
      else name);
  # set each name equal to 
  # its imported path
  attributes =
    (builtins.map
      (content:
        {
          name = formatName content;
          value = import (lib.path.append path content);
        })
      contents);
in
builtins.listToAttrs attributes
