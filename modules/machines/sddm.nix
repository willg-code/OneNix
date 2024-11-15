# Graphical login manager
{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.sddm-astronaut # theme package
  ];

  services.displayManager.sddm = {
    enable = true; # login screen compatible with hyprland
    wayland.enable = true; # native wayland support
    theme = "sddm-astronaut-theme"; # enable the previously declared theme
  };
}
