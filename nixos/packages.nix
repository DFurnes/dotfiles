{ config, pkgs, ...}:

{
  imports = [
    ../modules/system-packages.nix
  ];

  # System programs:
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  # Flatpak:
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    gnomeExtensions.appindicator
    gnomeExtensions.vitals
    vim
    binutils
    efibootmgr
    tcpdump
    unzip
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dfurnes" ];
  };

  # Mutable npm global installs:
  programs.npm.enable = true;
  programs.npm.npmrc = ''
    prefix = ''${HOME}/.npm
  '';
}
