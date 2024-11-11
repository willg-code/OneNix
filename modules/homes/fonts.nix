{ pkgs, ... }:

{
  fonts.fontconfig.enable = true; # allow font package discovery from home.packages

  home.packages = [
    pkgs.nerdfonts # all kinds of fonts
    pkgs.proggyfonts # another code font
    pkgs.overpass # sans serif font
  ];
}
