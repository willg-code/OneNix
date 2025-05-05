# PS3 Emulator
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "pcsx2";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.pcsx2
    ];
  };
}
