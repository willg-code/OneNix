{ inputs, ... }:
{
  programs.zsh = {
    enable = true; # shell with plugins
    package = inputs.nixpkgs-stable.legacyPackages.zsh;
  };

  # Kitty integration
  programs.kitty.settings.shell = "zsh";
}
