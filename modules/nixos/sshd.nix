# Enable and configure SSH daemon
# DOCS: https://nixos.wiki/wiki/SSH
{ config, lib, ... }:

let
  moduleName = "sshd";
  cfg = config.modules.nixos.${moduleName};
in
{
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true; # ssh daemon (sshd)
      settings = {
        X11Forwarding = true; # allow x11 (or xwayland) windows to be forwarded
        PermitRootLogin = "no"; # prohibit any root user logins because user accounts should be configured
        PasswordAuthentication = false; # disable password auth because keys should be enabled on accounts
        KbdInteractiveAuthentication = false; # disable other non-key authentication
      };
    };
  };
}
