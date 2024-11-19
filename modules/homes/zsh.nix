{ pkgs, ... }:

{
  programs.zsh = {
    enable = true; # shell with plugins
    autocd = true; # just type the dir name
    autosuggestion.enable = true; # right arrow to autocomplete
    oh-my-zsh = {
      enable = true; # plugin and theme manager
      plugins = [ "colorize" "colorized-man-pages" "ssh" "sudo" ]; # enabled plugins
      # theme = "gnzh";
    };
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
