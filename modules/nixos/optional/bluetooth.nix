# Bluetooth support
# DOCS: https://nixos.wiki/wiki/Bluetooth
{
  config,
  lib,
  ...
}: let
  moduleName = "bluetooth";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true; # bluetooth support/bluetooth cli
    services.blueman.enable = true; # bluetooth gui
  };
}
