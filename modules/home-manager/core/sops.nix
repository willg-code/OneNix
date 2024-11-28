{ config, inputs, secrets, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = secrets."${config.home.username}.yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt"; # expect age key here
  };
}
