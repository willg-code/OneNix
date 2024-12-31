# Graphical login manager
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "regreet";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true; # greeter service
      settings.default_session.command = "${lib.getExe pkgs.cage} -s -m last -- ${lib.getExe config.programs.regreet.package}";
    };
    programs.regreet.enable = true; # greeter
  };
}
