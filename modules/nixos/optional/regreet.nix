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
    programs.regreet = {
      enable = true; # greeter
      cageArgs = ["-s" "-m" "last"]; # get cage to display properly
    };
  };
}
