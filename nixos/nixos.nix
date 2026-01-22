# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix "experimental" features:
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Default settings for stateful data (e.g. file locations or database versions),
  # based on first install. Do not change without validating compatibility!
  system.stateVersion = "25.11";
}
