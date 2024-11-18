{ pkgs, ... }:
{
  programs.zsh = {
    enable = true; # shell with plugins
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
