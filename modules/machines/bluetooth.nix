# Bluetooth support
{ ... }:

{
  hardware.bluetooth.enable = true; # bluetooth support/bluetooth cli
  services.blueman.enable = true; # bluetooth gui
}
