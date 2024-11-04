# Root level configuration for the Hyprland desktop
# DOCS: https://nixos.wiki/wiki/Hyprland
{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kitty # quality of life: terminal which works by default
    pkgs.sddm-chili-theme # grey (neutral) theme for lock screen
  ];

  programs.hyprland.enable = true; # takes care of root level config

  services.displayManager.sddm = {
    enable = true; # lock screen compatible with hyprland
    wayland.enable = true; # native wayland support
    theme = "chili"; # enable the previously declared theme
  };
}
