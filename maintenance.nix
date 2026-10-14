{ config, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "00:01";
    options = "--delete-older-than 15d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "05:00" ];
  };

}
