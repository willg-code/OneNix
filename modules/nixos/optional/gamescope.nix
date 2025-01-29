# Tiny wayland compositor for games
{
  config,
  lib,
  ...
}: let
  moduleName = "gamescope";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
