# Secret management
{ inputs, secrets, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = secrets."secrets.yaml";
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # import ssh key as age key
      keyFile = "/var/lib/sops-nix/key.txt"; # output age key here
      generateKey = true; # generate it if not found
    };
  };
}
