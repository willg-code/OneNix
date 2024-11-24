{ config, lib, pkgs, ... }:

let
  moduleName = "swww";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
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
