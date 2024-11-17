lib:

# import the import dir function, which needs lib as an argument, 
# then call it on the current directory, 
# passing in lib to all imported files
import ./importDirWithArgs.nix lib ./. lib 
