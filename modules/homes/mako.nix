# Simple notification manager
{ ... }:

{
  services.mako.enable = true; # notification manager

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "mako"
  ];
}
