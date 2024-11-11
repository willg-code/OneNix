modules: username:

{ pkgs, ... }:

{
  imports = [
    modules.btop
    modules.cb
    modules.fastfetch
    modules.firefox
    modules.fonts
    modules.git
    modules.hypridle
    modules.hyprland
    modules.hyprlock
    modules.hyprpicker
    modules.hyprpolkitagent
    modules.kitty
    modules.mako
    modules.neovim
    modules.nordzy-cursors
    modules.rofi
    (modules.swww { switcher-script = (builtins.toString ./scripts/swww.sh); })
    modules.vscode
    modules.waybar
    modules.zsh
  ];

  home.packages = [
    pkgs.unzip # software for unzipping zip archives
  ];

  home.stateVersion = "24.05"; # Required for backwards compat during updates
}
