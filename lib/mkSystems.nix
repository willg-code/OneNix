### DESC ###
# Given flake inputs/outputs, output nixos systems
# with the flake inputs, overlays, modules, and secrets.
#
# Function input looks like this (called "builds"):
# [
#   {
#     machineConfig = <machine config>;
#     users = [
#       {
#         user = <user config>;
#         home = <home config>; (optional)
#       }
#       ... (more users)
#     ];
#     optimize-store = true; (optional)
#   };
# ]
#
# Alows two points of flexibility:
# - Each machine config is abstracted from the users provided to it, allowing users to be added and removed at-will.
# - Each user has an optional home, configured independently of the user itself, so homes can be swapped around at-will.
lib: {inputs}: builds:
lib.mapAttrs
(_: {
    machine,
    users,
  }:
    lib.nixosSystem {
      inherit lib; # lib contains flake lib as well as nixpkgs lib
      specialArgs = {inherit inputs;}; # inputs needs to be a specialArg
      modules =
        [
          inputs.self.outputs.nixosModules.default
          machine
        ]
        ++
        # User configurations.
        (
          lib.map
          ({
            user,
            home ? "",
          }: (import user home))
          users
        );
    })
builds
