# App launcher, dmenu, and run menu
{ config, lib, ... }:

let
  moduleName = "rofi";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.rofi.enable = true; # window switcher, app launcher, and dmenu

    # Hyprland integration
    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, D, exec, rofi -show drun"
      "$mainMod, R, exec, rofi -show run"
    ];
  };
}
