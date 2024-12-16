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
    age.keyFile = "/persistent/home/${config.home.username}/.config/sops/age/key"; # expect age key in persistent storage
  };

  home.persistence."/persistent/home/${config.home.username}".files = [
    ".config/sops/age/key"
  ];
}
