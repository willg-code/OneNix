{ pkgs, ... }:

{
  home.packages = [
    pkgs.clipboard-jh # clipboard manager
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "cb"
  ];
}
