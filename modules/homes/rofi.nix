{ ... }:

{
  programs.rofi.enable = true; # window switcher, app launcher, and dmenu

  # Hyprland integration
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, D, exec, rofi -show drun"
    "$mainMod, R, exec, rofi -show run"
  ];
}
