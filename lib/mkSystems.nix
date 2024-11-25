### DESC ###
# Given inputs, overlays, and modules, output nixos systems
# with those inputs, overlays, and modules.
#
# Input looks like this (called "builds"):
# {
#   <hostname> = {
#     machineConfig = <machine config>;
#     users = {
#       <username> = {
#         user = <user config>;
#         home = <home config>; (optional)
#         desc = <user description>; (optional)
#         email = <user email>; (optional)
#       };
#       ... (more users)
#     };
#     optimize-store = true; (optional)
#   };
# }
#
# Alows four points of flexibility:
# - Each machine config can be deployed to multiple differently-named computers if they have the same hardware
# - Each machine config is abstracted from the users provided to it, allowing users to be added and removed at-will.
# - Each user and home are identified by an arbitrary username, ensuring the accounts can be renamed if necessary
# - Each user has a home, configured independently of the user itself, so homes can be swapped around at-will.

### ARGS ###
lib:
{ inputs, overlays, modules }:

builds:
lib.mapAttrs
  (hostname: { machineConfig, users, optimize-store ? true }:
  lib.nixosSystem {
    inherit lib;
    specialArgs = { inherit inputs; };
    modules = [
      {
        _module.args = { inherit hostname; };
        nixpkgs.overlays = overlays;
        nix.settings.auto-optimise-store = optimize-store; # Enable store optimization on every build
      }
      modules.common # common modules
      modules.nixos # local nixos modules
      machineConfig
    ] ++
    # User configurations.
    (lib.concatLists
      (lib.attrValues
        (lib.mapAttrs
          (username: { user, home ? null, desc ? "", email ? "" }:
            [ (user { inherit username desc email; }) ] ++ # import the user config, and...
              # Check if a home config is provided (it might not be for system users)
              lib.optionals (home != null) [
                {
                  home-manager.users.${username}._module.args = { inherit hostname username desc email; };
                }
                {
                  home-manager.users.${username} = modules.home-manager; # local modules for HM
                }
                {
                  home-manager.users.${username} = home; # user config
                }
              ]
          )
          users
        )
      )
    );
  })
  builds
