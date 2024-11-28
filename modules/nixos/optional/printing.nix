# Printing support with CUPS and print-to-pdf
# DOCS: https://nixos.wiki/wiki/Printing
{
  config,
  lib,
  ...
}: let
  moduleName = "printing";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    services = {
      avahi = {
        enable = true; # network discovery
        nssmdns4 = true; # resolve .local domains
      };
      printing = {
        enable = true; # printing support with CUPS
        cups-pdf.enable = true; # enables print-to-pdf
      };
    };
  };
}
