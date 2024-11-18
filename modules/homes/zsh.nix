{ inputs, pkgs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.system; };
in
{
  programs.zsh = {
    enable = true; # shell with plugins
    package = pkgs-stable.zsh; # stable version
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
