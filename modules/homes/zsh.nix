{ ... }:
{
  programs.zsh = {
    # shell with plugins
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.path = "$HOME/.cache/zsh_history"; # so it's cleared with the cache
    oh-my-zsh = {
      # zsh plugin manager
      enable = true;
      plugins = [ "git" "z" ];
    };
  };
}
