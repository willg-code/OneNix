{ ... }:

{
  programs.waybar.enable = true; # system taskbar

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "waybar"
  ];
}
