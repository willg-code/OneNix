# Steam
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "steam";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist/home/${config.home.username}".directories = [
      ".steam"
      ".local/share/Steam"
    ];
  };
}
