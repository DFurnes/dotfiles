{ config, pkgs, lib, ... }:

{
  # Allow non-free packages:
  nixpkgs.config.allowUnfree = true;

  # Enable Nix "experimental" features:
  nix.settings.experimental-features = [ "flakes" "nix-command" ];
}
