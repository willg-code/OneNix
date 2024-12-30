# Code editor
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "zed-editor";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      # language servers
      pkgs.nixd
      pkgs.nil
      # formatters
      pkgs.alejandra
    ];
    programs.zed-editor = {
      enable = true;
      extensions = [
        "html"
        "nix"
      ];
      userSettings = {
        vim_mode = true;
        telemetry.metrics = false;
        ui_font_size = 16;
        buffer_font_size = 16;
        format_on_save = "on";
        lsp = {
          nil.settings.formatting.command = ["alejandra"];
          nixd.settings.formatting.command = ["alejandra"];
        };
      };
    };
  };
}
