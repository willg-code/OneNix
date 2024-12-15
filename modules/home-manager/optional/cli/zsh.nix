# Zshell
{
  config,
  lib,
  ...
}: let
  moduleName = "zsh";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true; # shell with plugins
      autosuggestion.enable = true; # right arrow to autocomplete
      oh-my-zsh = {
        enable = true; # plugin and theme manager
        plugins = ["colorize" "colored-man-pages" "ssh" "sudo"]; # enabled plugins
      };
      initExtra = "cl() { cd $1 && ll; }"; # add cd/ll alias as cl
    };

    # Kitty integration
    programs.kitty.settings.shell = "zsh";
  };
}
