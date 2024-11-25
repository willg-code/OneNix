# Version control tool
{ config, lib, email, desc, ... }:

let
  moduleName = "git";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
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
        # Configure user git identity
        userEmail = email;
        userName = desc;
      };
    };
  };
}
