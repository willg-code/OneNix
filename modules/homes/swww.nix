{ pkgs, ... }:

{
  home.packages = [
    pkgs.swww # wallpaper manager
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "swww-daemon"
  ];
}
