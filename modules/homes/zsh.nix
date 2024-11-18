{ pkgs, ... }:

{
  programs.zsh = {
    enable = true; # shell with plugins
    autocd = true; # just type the dir name
    autosuggestion.enable = true; # right arrow to autocomplete
    oh-my-zsh = {
      enable = true; # plugin and theme manager
      plugins = [ "git" "sudo" ]; # enabled plugins
      theme = "gnzh"; # enabled theme
    };
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
