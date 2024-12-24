# Code editor
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "zed-editor";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.zed-editor # code editor
    ];
  };
}
