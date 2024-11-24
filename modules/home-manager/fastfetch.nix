# Quick terminal system information tool
{ config, lib, ... }:

let
  moduleName = "fastfetch";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
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
  };
}
