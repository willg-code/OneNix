# Configurable system resource viewer
{ ... }:

{
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
}
