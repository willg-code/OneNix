# Zen browser module, fork of firefox
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  moduleName = "zen-browser";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}
      pkgs.speechd # for speech synthesis
    ];

    # add as default app
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = ["zen.desktop"];
        "x-scheme-handler/https" = ["zen.desktop"];
        "x-scheme-handler/chrome" = ["zen.desktop"];
        "text/html" = ["zen.desktop"];
        "application/x-extension-htm" = ["zen.desktop"];
        "application/x-extension-html" = ["zen.desktop"];
        "application/x-extension-shtml" = ["zen.desktop"];
        "application/xhtml+xml" = ["zen.desktop"];
        "application/x-extension-xhtml" = ["zen.desktop"];
        "application/x-extension-xht" = ["zen.desktop"];
      };
      associations.added = {
        "x-scheme-handler/http" = ["zen.desktop"];
        "x-scheme-handler/https" = ["zen.desktop"];
        "x-scheme-handler/chrome" = ["zen.desktop"];
        "text/html" = ["zen.desktop"];
        "application/x-extension-htm" = ["zen.desktop"];
        "application/x-extension-html" = ["zen.desktop"];
        "application/x-extension-shtml" = ["zen.desktop"];
        "application/xhtml+xml" = ["zen.desktop"];
        "application/x-extension-xhtml" = ["zen.desktop"];
        "application/x-extension-xht" = ["zen.desktop"];
      };
    };

    # NOTE: NOT CURRENTLY FULLY DECLARATIVELY CONFIGED
    # NIX PACKAGE STILL IN DEVELOPMENT
  };
}
