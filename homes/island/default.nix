user:

{ pkgs, lib, ... }:

{
  # Modules
  modules.homes.btop.enable = true;
  modules.homes.fastfetch.enable = true;
  modules.homes.fonts.enable = true;
  modules.homes.git.enable = true;
  modules.homes.hyprland.enable = true;
  modules.homes.kitty.enable = true;
  modules.homes.mako.enable = true;
  modules.homes.nh.enable = true;
  modules.homes.phinger-cursor-theme.enable = true;
  modules.homes.rofi.enable = true;
  modules.homes.screenshot.enable = true;
  modules.homes.starship.enable = true;
  modules.homes.swww.enable = true;
  modules.homes.vscode.enable = true;
  modules.homes.waybar.enable = true;
  modules.homes.zen-browser.enable = true;
  modules.homes.zsh.enable = true;

  # Colors
  modules.homes.colors = {
    primary = "09849B";
    primaryHighlight = "5CC1A1";
    primaryLowlight = "023354";
    secondary = "429346";
    secondaryHighlight = "55B16B";
    secondaryLowlight = "123C2F";
    neutralLight = "D6E1DF";
    neutralDark = "020F1B";
  };

  # Other
  home.packages = [
    pkgs.unzip # software for unzipping zip archives
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    # invoke wallpaper switcher script
    (lib.concatStringsSep " "
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
