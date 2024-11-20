{ config, lib, pkgs, ... }:

let
  moduleName = "vscode";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nixpkgs-fmt ];
    programs.vscode = {
      enable = true; # temporary text editor
      extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ]; # nix editor extension
      userSettings = {
        "editor.formatOnSave" = "true"; # use the nixfmt formatter on save
        "git.autoFetch" = true; # fetch git periodically
      };
    };
  };
}
