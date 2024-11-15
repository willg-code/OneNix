# Nvidia compatability settings
# DOCS: https://nixos.wiki/wiki/Nvidia
{ ... }:

{
  nixpkgs.config.allowUnfree = true; # nvidia drivers are unfree

  services.xserver.videoDrivers = [ "nvidia" ]; # set driver for compositor

  hardware = {
    graphics.enable = true; # enable hardeware graphics acceleration
    nvidia = {
      modesetting.enable = true; # necessary for wayland
      powermanagement.enable = true; # save entire vram to /tmp on suspend
      powermanagement.finegrained = true; # turn off GPU when not in use
      open = true; # open kernel module
      nvidiaSettings = true; # settings menu accessible in OS
    };
  };
}
