# Zen browser module, fork of firefox
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "atlauncher";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.atlauncher
    ];
  };
}
