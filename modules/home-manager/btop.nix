# Configurable system resource viewer
{ config, lib, ... }:

let
  moduleName = "btop";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true; # system resource viewer
      settings = {
        color_theme = "gruvbox_dark"; # easier on the eyes
        theme_background = false; # transparency if available
        shown_boxes = "proc cpu mem net gpu0"; # add gpu to data if available
        proc_tree = true; # show procs as a tree
        disks_filter = "exclude=/boot"; # don't show boot partition
      };
    };
  };
}
