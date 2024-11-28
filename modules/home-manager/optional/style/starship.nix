# Cross shell prompt
{
  config,
  lib,
  ...
}: let
  moduleName = "starship";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.starship.enable = true;
  };
}
