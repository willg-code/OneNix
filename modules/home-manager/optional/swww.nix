# Wayland wallpaper tool
{ config, lib, pkgs, ... }:

let
  moduleName = "swww";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
    switcher = lib.mkOption { default = null; type = (lib.types.nullOr (lib.types.uniq lib.types.path)); };
  };

  config = lib.mkIf cfg.enable {
    warnings =
      if (cfg.switcher == null)
      then [ "no wallpaper switcher script has been provided to swww" ]
      else [ ];

    home.packages = [
      pkgs.swww # wallpaper manager
    ];

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec-once = [
      "uwsm app -- swww-daemon"
    ] ++ lib.optionals (cfg.switcher != null) [ "uwsm app -- ${cfg.switcher}" ];
  };
}
