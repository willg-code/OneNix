# Nix CLI helper with expanded GC and QOL enhancements
{ config, lib, ... }:

let
  moduleName = "nh";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true; # cli helper
      clean = {
        enable = true; # garbage collector
        dates = "daily"; # clean daily
        extraArgs = "--keep-since 3d"; # keep generations newer than 3 days
      };
    };
  };
}
