# Uses wayshot and satty to capture/annotate a wayland screen grab
{ config, lib, pkgs, ... }:

let
  moduleName = "screenshot";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.satty # screenshot annotator
      pkgs.wayshot # screenshot tool
    ];

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, P, exec, wayshot --stdout | satty -f -"
    ];
  };
}
