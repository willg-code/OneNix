# Secret management
{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = inputs.self.outputs.secrets."secrets.yaml";
    age.keyFile = "/persist/var/lib/sops-nix/keys.txt";
  };

  environment.persistence."/persist".files = [
    "/var/lib/sops-nix/keys.txt" # mount key to /var/lib so I don't need to remember it's in /persist
  ];
}
