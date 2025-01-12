{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = inputs.self.outputs.secrets."${config.home.username}.yaml";
    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";
  };
}
