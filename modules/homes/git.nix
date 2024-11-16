# Version control tool
{ ... }:

{
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
}
