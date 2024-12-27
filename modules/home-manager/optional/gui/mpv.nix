# MPV player
{
  config,
  lib,
  ...
}: let
  moduleName = "mpv";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
