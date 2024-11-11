modules: username:

{ config, lib, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]
      ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ]
      ++ lib.optionals config.virtualisation.docker.enable [ "docker" ];
    initialPassword = "";
    home = "/home/${username}";
    openssh.authorizedKeys.keyFiles = [
      ./pubkeys/willg.pub
    ];
    description = "William Greenlee";
  };
}
