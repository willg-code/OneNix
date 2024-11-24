# Audio/videocap/bluetooth all in one
# DOCS: https://nixos.wiki/wiki/PipeWire
{ config, lib, ... }:

let
  moduleName = "pipewire";
  cfg = config.modules.machines.${moduleName};
in
{
  options.modules.machines.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true; # realtime processing for latency reduction
    services = {
      pipewire = {
        enable = true; # pipewire daemon
        alsa.enable = true; # alsa compat support
        alsa.support32Bit = true; # 32-bit (hifi) alsa support
        pulse.enable = true; # pulseaudio compat support
        jack.enable = true; # jack app support (common in low latency environments)
      };
    };
  };
}
