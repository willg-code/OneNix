# Nvidia compatability settings
# DOCS: https://nixos.wiki/wiki/Nvidia
{ config, ... }:

{
  nixpkgs.config.allowUnfree = true; # nvidia drivers are unfree

  services.xserver.videoDrivers = [ "nvidia" ]; # set driver for compositor

  hardware = {
    graphics.enable = true; # enable hardeware graphics acceleration
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta; # enable beta driver
      modesetting.enable = true; # necessary for wayland
      powerManagement.enable = true; # save entire vram to /tmp on suspend
      open = true; # open kernel module
      nvidiaSettings = true; # settings menu accessible in OS
    };
  };
}
