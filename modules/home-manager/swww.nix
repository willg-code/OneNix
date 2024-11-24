{ config, lib, pkgs, ... }:

let
  moduleName = "swww";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.swww # wallpaper manager
    ];

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec-once = [
      "swww-daemon"
    ];
  };
}
