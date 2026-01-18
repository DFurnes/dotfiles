# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ../modules/system-packages.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 0;

  # Nix "experimental" features:
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  networking.hostName = "desktop";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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
   
  programs.zsh.enable = true;
   
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    binutils
    efibootmgr
    tcpdump
    unzip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryPackage = pkgs.pinentry-gnome3;
  # };

  # List services that you want to enable:
  programs.npm.enable = true;
  programs.npm.npmrc = ''
    prefix = ''${HOME}/.npm
  '';

  # Use GNOME Keyring for secrets, but NOT as the SSH agent.
  # services.gnome.gnome-keyring.enable = true;
  # services.gnome.gcr-ssh-agent.enable = false;
  # programs.seahorse.enable = true;
  # services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];

  # Make PAM unlock/start the keyring on login (GDM)
  # security.pam.services.gdm.enableGnomeKeyring = true;
  # security.pam.services.gdm-password.enableGnomeKeyring = true;

  # Don’t run a competing OpenSSH agent
  # programs.ssh.startAgent = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Avahi:
  services.avahi = {
    enable = true;
    nssmdns4 = true; # .local name resolution on IPv4
    openFirewall = true; # allow 5353, etc.
    publish.enable = true;
    publish.userServices = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
