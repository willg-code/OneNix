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
          "davidde/git"
        ];
      };
    autocd = true; # automatically CD a directory if typed directly
  };
}
