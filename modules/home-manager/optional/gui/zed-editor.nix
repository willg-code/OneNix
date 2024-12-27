# Code editor
{
  config,
  lib,
  ...
}: let
  moduleName = "zed-editor";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
      ];
      userSettings = {
        vim_mode = true;
        telemetry.metrics = false;
        ui_font_size = 16;
        buffer_font_size = 16;
      };
    };
  };
}
