# GRUB boot loader and plymouth splash screen
# DOCS: https://nixos.wiki/wiki/Grub
{ logo ? null }:
{ pkgs, ... }:

{
  boot = {
    loader = {
      grub = {
        enable = true; # universal boot loader for x86
        efiSupport = true; # install as an efi bootloader
        useOSProber = true; # detect other boot options (like a Windows installation)
        theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze"; # theme for grub
        memtest86.enable = true; # add mem test as a boot option
      };
      efi.canTouchEfiVariables = true; # allows installer to change efi variables (to enable boot options)
    };
    tmp.cleanOnBoot = true; # helps cut down on disk usage, tmp is safe to clean at boot
    plymouth = {
      enable = true; # flicker-free splash screen
      theme = "breeze"; # replace the default boot screen with a breeze theme
      logo = mkif !(isNull logo) logo;
    };
  };
}
