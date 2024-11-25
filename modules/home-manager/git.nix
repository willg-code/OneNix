# Version control tool
{ config, lib, username, ... }:

let
  moduleName = "git";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."email" = { };
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
        userEmail = lib.readFile config.sops.secrets."email".path; # user email secret
        userName = username; # username
      };
    };
  };
}
