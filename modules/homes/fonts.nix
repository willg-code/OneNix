# Common font configuration for all systems
{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true; # allow font package discovery from home.packages
  };

  home.packages = [
    pkgs.nerdfonts # code fonts
    pkgs.noto-fonts # everything else
  ];
}
