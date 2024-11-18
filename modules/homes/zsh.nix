{ pkgs, ... }:
{
  programs.zsh = {
    enable = true; # shell with plugins
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
