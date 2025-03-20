# Note taking app
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "obsidian";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
}
