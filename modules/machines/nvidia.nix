# DOCS: https://nixos.wiki/wiki/Nvidia
{ ... }:

{
  nixpkgs.config.allowUnfree = true; # nvidia drivers are unfree

  services.xserver.videoDrivers = [ "nvidia" ]; # set driver for compositor

  hardware = {
    graphics.enable = true; # enable opengl graphics
    nvidia = {
      modesetting.enable = true; # necessary for wayland
      open = true; # open kernel module
      nvidiaSettings = true; # settings menu accessible in OS
    };
  };
}
