# Secret management
{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = inputs.self.outputs.secrets."secrets.yaml";
    age = {
      keyFile = "/var/lib/sops-nix/key"; # output age key here
    };
  };

  environment.persistence."/persistent".files = [
    "/var/lib/sops-nix/key" # keep the key after it's generated
  ];
}
