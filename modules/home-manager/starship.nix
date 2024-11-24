# Cross shell prompt
{ config, lib, ... }:

let
  moduleName = "starship";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = { };
    };
  };
}
