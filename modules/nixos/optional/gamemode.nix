# Linux game performance optimization tool
{
  config,
  lib,
  ...
}: let
  moduleName = "gamemode";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
      };
    };
  };
}
