# Uses wayshot and satty to capture/annotate a wayland screen grab
{ pkgs, ... }:

{
  home.packages = [
    pkgs.satty # screenshot annotator
    pkgs.wayshot # screenshot tool
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, P, exec, wayshot --stdout | satty -f -"
  ];
}
