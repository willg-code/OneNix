{ inputs, ... }:
{
  programs.zsh = {
    enable = true; # shell with plugins
    package = inputs.nixpkgs-stable.zsh;
  };
}
