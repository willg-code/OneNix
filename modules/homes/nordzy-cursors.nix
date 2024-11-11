{ pkgs, ... }:

{
  home.packages = [
    pkgs.nordzy-cursor-theme
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor Nordzy-cursors 24"
  ];
}
