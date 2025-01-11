{pkgs, ...}: {
  # Modules/CLI
  modules.home-manager.btop.enable = true;
  modules.home-manager.fastfetch.enable = true;
  modules.home-manager.git.enable = true;
  modules.home-manager.nh.enable = true;
  modules.home-manager.nixos-generators.enable = true;
  modules.home-manager.ssh.enable = true;
  modules.home-manager.starship.enable = true;
  modules.home-manager.unzip.enable = true;
  modules.home-manager.yazi.enable = true;
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
  modules.home-manager.mpv.enable = true;
  modules.home-manager.protonup-qt.enable = true;
  modules.home-manager.screenshot.enable = true;
  modules.home-manager.swww = {
    enable = true;
    switcher = pkgs.writeShellScript "earth.sh" ''swww img "${./assets/earth.jpg}" --transition-type none'';
  };
  modules.home-manager.waybar.enable = true;
  modules.home-manager.webcord.enable = true;
  modules.home-manager.zed-editor.enable = true;
  modules.home-manager.zen-browser.enable = true;

  # Stylix
  stylix = {
    enable = true;
    image = ./assets/earth.jpg;
    opacity.terminal = 0.9;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      monospace = {
        package = pkgs.noto-fonts;
        name = "Noto Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-monochrome-emoji;
        name = "Noto Emoji";
      };
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
    };
  };

  programs.home-manager.enable = true; # let HM control itself
  home.stateVersion = "24.11"; # Required for backwards compat during updates
}
