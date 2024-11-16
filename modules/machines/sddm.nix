# Graphical login manager
{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.catppuccin-sddm # theme package
  ];

  services.displayManager.sddm = {
    enable = true; # login screen compatible with hyprland
    wayland.enable = true; # native wayland support
    theme = "catppuccin-mocha"; # enable the previously declared theme
  };
}
