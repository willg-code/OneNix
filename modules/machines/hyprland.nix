# Root level configuration for the Hyprland desktop
# DOCS: https://nixos.wiki/wiki/Hyprland
{ config, lib, ... }:

let
  moduleName = "hyprland";
  cfg = config.modules.machines.${moduleName};
in
{
  options.modules.machines.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true; # takes care of root level config
    services.displayManager.defaultSession = "hyprland"; # set hyprland as default login session
  };
}
