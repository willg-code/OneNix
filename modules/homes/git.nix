# Version control tool
{ config, lib, ... }:

let
  moduleName = "git";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true; # version control
        aliases = {
          # shortened commands
          c = "commit";
          cm = "commit -m";
          co = "checkout";
          pl = "pull";
          ps = "push";
          stat = "status";
          a = "add";
          aa = "add *";
        };
      };
    };
  };
}
