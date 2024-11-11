{ ... }:

{
  programs.fastfetch = {
    enable = true; # system configuration display
    settings = {
      modules = [
        # components of the output
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "processes"
        "packages"
        "shell"
        "resolution"
        "lm"
        "de"
        "wm"
        "theme"
        "icons"
        "font"
        "terminal"
        "terminalfont"
        "terminaltheme"
        "cpu"
        "gpu"
        "memory"
        "version"
        "break"
        "colors"
      ];
    };
  };
}
