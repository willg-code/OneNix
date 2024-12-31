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
    services.greetd.enable = true; # greeter service
    programs.regreet.enable = true; # greeter
  };
}
