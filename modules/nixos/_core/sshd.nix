# Enable and configure SSH daemon
# Required because SOPS uses the key
# DOCS: https://nixos.wiki/wiki/SSH
{ ... }:

{
  services.openssh = {
    enable = true; # ssh daemon (sshd)
    settings = {
      X11Forwarding = true; # allow x11 (or xwayland) windows to be forwarded
      PermitRootLogin = "no"; # prohibit any root user logins because user accounts should be configured
      PasswordAuthentication = false; # disable password auth because keys should be enabled on accounts
      KbdInteractiveAuthentication = false; # disable other non-key authentication
    };
  };
}
