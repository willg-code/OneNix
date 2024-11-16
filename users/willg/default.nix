modules:
rec {
  config =
    (username:

      { config, lib, ... }:

      {
        users.users.${username} = {
          isNormalUser = true;
          extraGroups = [ "wheel" ]
            ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ]
            ++ lib.optionals config.virtualisation.docker.enable [ "docker" ];
          initialPassword = "";
          openssh.authorizedKeys.keyFiles = [
            ./pubkeys/willg.pub
          ];
          description = name;
        };
      }
    );

  name = "Will G.";
  email = "greenlee04@gmail.com";
}
