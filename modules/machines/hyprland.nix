# Root level configuration for the Hyprland desktop
# DOCS: https://nixos.wiki/wiki/Hyprland
{ ... }:

{
  programs.hyprland.enable = true; # takes care of root level config
  services.displayManager.defaultSession = "hyprland"; # set hyprland as default login session
}
