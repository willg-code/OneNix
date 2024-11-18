{ pkgs, ... }:

{
  home.packages = [
    pkgs.hyprpicker # color picker for hyprland
    pkgs.wl-clipboard-rs # wl-clipboard implementation, required for hyprpicker -a
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod $shiftMod, P, exec, hyprpicker -ar"
  ];
}
