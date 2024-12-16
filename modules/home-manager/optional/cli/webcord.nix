# Open source discord frontend
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "webcord";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.webcord # discord client with wl support
    ];
  };
}
