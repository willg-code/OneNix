# Unarchiving tool
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "unzip";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.unzip # software for unzipping zip archives
    ];
  };
}
