{ ... }:
{
  programs.zsh = {
    # shell with plugins
    enable = true;
    antidote =
      {
        enable = true;
        plugins = [
          "zsh-users/zsh-autosuggestions"
          "chrissicool/zsh-256color"
          "dark-kitt/zsh-git-plugin"
        ];
      };
    autocd = true; # automatically CD a directory if typed directly
    history.path = "$HOME/.cache/zsh_history"; # so it's cleared with the cache
    dotDir = ".config/zsh"; # move dotfile to config folder
  };
}
