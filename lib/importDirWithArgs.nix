### DESC ###
# Constructs a set containing an import of every file
# found on the given path and passes in args:
#
# {
#   <filename> = import <filename> args;
# }

lib:
path:
args:

(lib.mapAttrs (_: func: (func args)) (lib.importDir lib path))
