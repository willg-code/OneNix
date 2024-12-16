# Proton install tool
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "protonup-qt";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.protonup-qt # proton ge installer
    ];
    home.persistence."/persist/home/${config.home.username}".directories = [
      ".config/pupgui"
    ];
  };
}
