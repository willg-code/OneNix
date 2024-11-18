# Nix CLI helper with expanded GC and QOL enhancements
{ ... }:

{
  programs.nh = {
    enable = true; # cli helper
    clean = {
      enable = true; # garbage collector
      extraArgs = "--keep-since 3d"; # keep generations newer than 3 days
    };
  };

  nix.gc.automatic = false;
}
