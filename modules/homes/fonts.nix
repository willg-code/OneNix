# Common font configuration for all systems
{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true; # allow font package discovery from home.packages
    defaultFonts = {
      monospace = [ "Overpass Mono" ];
      sansSerif = [ "Overpass" ];
    };
  };

  home.packages = [
    pkgs.nerdfonts # code fonts
    pkgs.overpass # pretty sans-serif/mono font
    pkgs.noto-fonts # everything else
  ];
}
