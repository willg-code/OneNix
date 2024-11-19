### DESC ###
# Constructs a set containing an import of every file
# found on the inputted path, provided args as an input:
#
# {
#   <filename> = import <filename> args;
# }
#
# NOTE: For sake of convenience, the ".nix"
#       is stripped from the names with ".nix" 
#       at the end
#
#       example.nix -> example

### INTER-LIB DEPS ###
let
  importDir = import ./impDir.nix;
in

### ARGS ###
lib: # needed for importing importDir
path: # passed into importDir
args: # args to be passed into imported files

builtins.mapAttrs # map the output of importDir
  (name: func: (func args)) # call each imported function using the args
  (importDir lib path) # call importDir on the path using lib
