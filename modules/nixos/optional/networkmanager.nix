# Networkmanager, dynamically ensures a network connection is
# used if it is available
{ config, lib, ... }:

let
  moduleName = "networkmanager";
  cfg = config.modules.nixos.${moduleName};
in
{
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true; # networkmanager
  };
}
