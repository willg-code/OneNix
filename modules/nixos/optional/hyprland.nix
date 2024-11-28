# Root level configuration for the Hyprland desktop
# DOCS: https://nixos.wiki/wiki/Hyprland
{ config, lib, ... }:

let
  moduleName = "hyprland";
  cfg = config.modules.nixos.${moduleName};
in
{
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland
    programs.hyprland = {
      enable = true; # takes care of root level config
      withUWSM = true; # use Universal Wayland Session Manager
    };
  };
}
