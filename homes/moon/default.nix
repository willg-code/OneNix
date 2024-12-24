{pkgs, ...}: {
  # Modules/CLI
  modules.home-manager.btop.enable = true;
  modules.home-manager.fastfetch.enable = true;
  modules.home-manager.git.enable = true;
  modules.home-manager.nh.enable = true;
  modules.home-manager.nixos-generators.enable = true;
  modules.home-manager.protonup-qt.enable = true;
  modules.home-manager.ssh.enable = true;
  modules.home-manager.unzip.enable = true;
  modules.home-manager.zsh.enable = true;

  # Modules/GUI
  modules.home-manager.hyprland.enable = true;
  modules.home-manager.hyprlock.enable = true;
  modules.home-manager.fuzzel.enable = true;
  modules.home-manager.hypridle.enable = true;
  modules.home-manager.hyprpicker.enable = true;
  modules.home-manager.hyprpolkitagent.enable = true;
  modules.home-manager.kitty.enable = true;
  modules.home-manager.mako.enable = true;
  modules.home-manager.screenshot.enable = true;
  modules.home-manager.swww = {
    enable = true;
    switcher = pkgs.writeShellScript "moon.sh" ''swww img "${./assets/moon.jpg}" --transition-type none'';
  };
  modules.home-manager.vscode.enable = true;
  modules.home-manager.waybar.enable = true;
  modules.home-manager.webcord.enable = true;
  modules.home-manager.zed-editor.enable = true;
  modules.home-manager.zen-browser.enable = true;

  # Modules/Style
  modules.home-manager.notonerd-fonts.enable = true;
  modules.home-manager.phinger-cursor.enable = true;
  modules.home-manager.starship.enable = true;

  # Stylix
  stylix = {
    enable = true;
    image = ./assets/moon.jpg;
    opacity.terminal = 0.85;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-plateau.yaml";
  };

  programs.home-manager.enable = true; # let HM control itself
  home.stateVersion = "24.11"; # Required for backwards compat during updates
}
