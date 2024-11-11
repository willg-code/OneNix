modules: username:

{ pkgs, ... }:

{
  imports = [
    modules.btop
    modules.fastfetch
    modules.firefox
    modules.fonts
    modules.git
    modules.hyprland
    modules.neovim
    modules.vscode
    modules.zsh
  ];

  home.packages = [
    pkgs.unzip # software for unzipping zip archives
  ];

  home.stateVersion = "24.05"; # Required for backwards compat during updates
}
