# Phinger cursor theme integration with stylix
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "phinger-cursor";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
      };
    };
  };
}
