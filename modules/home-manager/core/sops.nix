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
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt"; # expect age key here
  };

  home.persistence."/persistent/home/${config.home.username}".files = [
    ".config/sops/age/keys.txt"
  ]
}
