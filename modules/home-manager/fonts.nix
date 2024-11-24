# Common font configuration for all systems
{ config, lib, pkgs, ... }:

let
  moduleName = "fonts";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true; # allow font package discovery from home.packages
    };

    home.packages = [
      pkgs.nerdfonts # code fonts
      pkgs.noto-fonts # everything else
    ];
  };
}

