# Graphical login manager
{
  config,
  lib,
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
      settings.default_session.command = "cage -s -m last -- regreet";
    };
    programs.regreet.enable = true; # greeter
  };
}
