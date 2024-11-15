let
  importDir = import ./importDir.nix;
in
lib:
path:
args:

builtins.mapAttrs
  (name: func: (func args))
  (importDir lib path)
