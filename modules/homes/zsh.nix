{ ... }:
{
  programs.zsh = {
    # shell with plugins
    enable = true;
    autocd = true; # automatically CD a directory if typed directly
    autosuggestion = {
      enable = true; # automatically suggest completions
      strategy = [
        "history" # based on command history
        "completion" #based on tab completion
      ];
    };
    syntaxHighlighting.enable = true;
    history.path = "$HOME/.cache/zsh_history"; # so it's cleared with the cache
    dotDir = "$HOME/.config/zsh";
  };
}
