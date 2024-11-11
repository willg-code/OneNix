{ pkgs, ... }:

{
  home.packages = [
    pkgs.hyprpicker # color picker for hyprland
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, P, exec, hyprpicker -a"
  ];
}
