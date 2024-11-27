{ pkgs, lib, ... }:

{
  # Modules
  modules.home-manager.btop.enable = true;
  modules.home-manager.fastfetch.enable = true;
  modules.home-manager.git.enable = true;
  modules.home-manager.hyprland.enable = true;
  modules.home-manager.kitty.enable = true;
  modules.home-manager.mako.enable = true;
  modules.home-manager.nh.enable = true;
  modules.home-manager.notonerd-fonts.enable = true;
  modules.home-manager.phinger-cursor.enable = true;
  modules.home-manager.rofi.enable = true;
  modules.home-manager.screenshot.enable = true;
  modules.home-manager.starship.enable = true;
  modules.home-manager.swww = {
    enable = true;
    switcher = pkgs.writeShellScript "moon.sh" ''swww img "${./assets/moon.jpg}" --transition-type none'';
  };
  modules.home-manager.ssh.enable = true;
  modules.home-manager.vscode.enable = true;
  modules.home-manager.waybar.enable = true;
  modules.home-manager.zen-browser.enable = true;
  modules.home-manager.zsh.enable = true;

  # Stylix
  stylix = {
    enable = true;
    image = ./assets/moon.jpg;
    opacity.terminal = 0.85;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
  };

  # Other
  home.packages = [
    pkgs.unzip # software for unzipping zip archives
  ];

  programs.home-manager.enable = true; # let HM control itself
  home.stateVersion = "24.05"; # Required for backwards compat during updates
}