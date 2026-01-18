# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ../modules/system-packages.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix "experimental" features:
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Bootloader:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 0;

  # Networking:
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # Time zone & i18n:
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Desktop environment:
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dfurnes = {
    isNormalUser = true;
    description = "David Furnes";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; 
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPT03WzkjZo7eQlGCgP+kuvs3f4A/s6MoEbITrIChOv+ david@dfurnes.com"
    ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
   
  # System programs:
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  # Flatpak:
  services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    binutils
    efibootmgr
    tcpdump
    unzip
  ];

  # List services that you want to enable:
  programs.npm.enable = true;
  programs.npm.npmrc = ''
    prefix = ''${HOME}/.npm
  '';

  # OpenSSH server & Avahi:
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  # Avahi:
  services.avahi = {
    enable = true;
    nssmdns4 = true; # .local name resolution on IPv4
    openFirewall = true; # allow 5353, etc.
    publish.enable = true;
    publish.userServices = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Default settings for stateful data (e.g. file locations or database versions),
  # based on first install. Do not change without validating compatibility!
  system.stateVersion = "25.11";
}
