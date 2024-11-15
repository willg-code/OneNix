# Systemd boot loader and plymouth splash screen
# DOCS: https://nixos.wiki/wiki/Grub
{ ... }:

{
  boot = {
    loader.systemd-boot = {
      enable = true; # enable bootloader
      editor = false; # no command line boot entry; security risk
      memtest86.enable = true; # mem test available in bootloader
      configurationLimit = 10; # max number of configuration boot entries
    };
    loader.efi.canTouchEfiVariables = true; # allows installer to change efi variables (to enable boot option)
    tmp.cleanOnBoot = true; # helps cut down on disk usage, tmp is safe to clean at boot
    plymouth = {
      enable = true; # flicker-free splash screen
      theme = "breeze"; # replace the default boot screen with a breeze theme
    };
  };
}
