# Nix CLI helper with expanded GC and QOL enhancements
{ ... }:

{
  programs.nh = {
    enable = true; # cli helper
    clean = {
      enable = true; # garbage collector
      dates = "daily"; # clean daily
      extraArgs = "--keep-since 3d"; # keep generations newer than 3 days
    };
  };
}
