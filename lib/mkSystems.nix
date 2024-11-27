### DESC ###
# Given inputs, overlays, and modules, output nixos systems
# with those inputs, overlays, and modules.
#
# Input looks like this (called "builds"):
# {
#   <hostname> = {
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
# }
#
# Alows three points of flexibility:
# - Each machine config can be deployed to multiple differently-named computers if they have the same hardware
# - Each machine config is abstracted from the users provided to it, allowing users to be added and removed at-will.
# - Each user has an optional home, configured independently of the user itself, so homes can be swapped around at-will.

lib:
{ inputs, overlays, modules, secrets }:

builds:
lib.mapAttrs
  (hostname: { machineConfig, users, optimize-store ? true }:
  lib.nixosSystem {
    inherit lib;
    specialArgs = { inherit inputs; }; # inputs needs to be a specialArg
    modules = [
      {
        _module.args = { inherit hostname secrets; };
        nixpkgs.overlays = overlays;
        nix.settings.auto-optimise-store = optimize-store;
      }
      machineConfig
      modules.nixos
    ] ++
    # User configurations.
    (lib.map
      ({ user, home ? null }: (import user [ home modules.home-manager ]))
      users
    );
  })
  builds
