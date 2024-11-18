modules:
user:

{ pkgs, ... }:

{
  imports = [
    modules.btop
    modules.fastfetch
    modules.fonts
    modules.git
    modules.hyprland
    modules.kitty
    modules.mako
    modules.nordzy-cursors
    modules.rofi
    modules.screenshot
    modules.swww
    modules.vscode
    modules.waybar
    modules.zen-browser
    modules.zsh
  ];

  home.packages = [
    pkgs.unzip # software for unzipping zip archives
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    # invoke wallpaper switcher script
    (builtins.concatStringsSep " "
      [
        ./scripts/swww.sh
        ./assets/morning.jpg
        ./assets/day.jpg
        ./assets/evening.jpg
        ./assets/night.jpg
      ]
    )
  ];

  # Configure user git identity
  programs.git.userEmail = user.email;
  programs.git.userName = user.name;

  home.stateVersion = "24.05"; # Required for backwards compat during updates
}
