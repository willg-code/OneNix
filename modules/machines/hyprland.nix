# Root level configuration for the Hyprland desktop
# DOCS: https://nixos.wiki/wiki/Hyprland
{ ... }:

{
  programs.hyprland.enable = true; # takes care of root level config
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland
  services.displayManager.defaultSession = "hyprland";
}
