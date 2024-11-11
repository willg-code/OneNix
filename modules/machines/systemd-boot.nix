# GRUB boot loader and plymouth splash screen
# DOCS: https://nixos.wiki/wiki/Grub
{ logo ? null }:
{ lib, ... }:

{
  boot = {
    loader.systemd-boot = {
      enable = true;
      editor = false;
      memtest86.enable = true;
    };
    loader.efi.canTouchEfiVariables = true; # allows installer to change efi variables (to enable boot options)
    tmp.cleanOnBoot = true; # helps cut down on disk usage, tmp is safe to clean at boot
    plymouth = {
      enable = true; # flicker-free splash screen
      theme = "breeze"; # replace the default boot screen with a breeze theme
    } // lib.optionalAttrs (!(builtins.isNull logo)) { inherit logo; };
  };
}
