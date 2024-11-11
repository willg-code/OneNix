{ pkgs, ... }:

{
  home.packages = [ pkgs.nixpkgs-fmt ];
  programs.vscode = {
    enable = true; # temporary text editor
    extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ]; # nix editor extension
    userSettings = {
      "editor.formatOnSave" = "true"; # use the nixfmt formatter on save
    };
  };
}
