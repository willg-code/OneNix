# Gaming platform for linux
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "lutris";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.lutris
      pkgs.wineWowPackages.unstableFull
      pkgs.pcsx2
    ];
  };
}
