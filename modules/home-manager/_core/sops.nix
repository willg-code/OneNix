{ config, inputs, secrets, username, ... }:

{
  imports = [
    #inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = secrets.${username};
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt"; # expect age key here
  };
}
