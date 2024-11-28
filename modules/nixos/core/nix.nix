# Global nix config
{
  inputs,
  lib,
  ...
}: {
  nix = {
    registry = lib.mapAttrs (_: flake: {inherit flake;}) inputs; # Use the system flake registry, map all inputs
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs; # Update nix path to refer to the system registry for legacy compatability
    channel.enable = false;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      flake-registry = ""; # Disable global flake registry
    };
  };
}
