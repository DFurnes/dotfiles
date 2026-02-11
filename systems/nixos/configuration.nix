# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/defaults.nix
    ../../modules/system-packages.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      dropbox-cli = prev.dropbox-cli // {
        nautilusExtension =
          prev.dropbox-cli.nautilusExtension.overrideAttrs (_old: {
            configureFlags = [
              "--with-nautilus-extension-dir=${placeholder "nautilusExtension"}/lib/nautilus/extensions-4"
            ];
          });
      };
    })
  ];


  # To search: `$ nix search wget`
  environment.systemPackages = with pkgs; [
    _1password-gui
    dropbox-cli
    dropbox-cli.nautilusExtension
    gnomeExtensions.appindicator
    gnomeExtensions.vitals
    binutils
    efibootmgr
    tcpdump
  ];

  environment.extraOutputsToInstall = [ "nautilusExtension" ];

  # Flatpak:
  services.flatpak.enable = true;

  # System programs:
  programs.zsh.enable = true;
  programs.firefox.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "dfurnes" ];
  };

  # Automatic updates:
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos";
  };

  # Step 1: update flake.lock (optionally commit it)
  systemd.services.flake-update = {
    description = "Update flake inputs";
    before = [ "nixos-upgrade.service" ];
    requiredBy = [ "nixos-upgrade.service" ];

    path = [ pkgs.nix ];
    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = "/etc/nixos";

      ExecStart = "${pkgs.nix}/bin/nix flake update --flake /etc/nixos";
    };
  };

  # Step 2: make nixos-upgrade wait for flake-update
  systemd.services.nixos-upgrade = {
    after = [ "flake-update.service" ];
    wants = [ "flake-update.service" ];
  };

  # Use 'systemd-resolved' for DNS, which works around
  # an issue where legacy 'resolv.conf' isn't ready yet
  # when 'autoUpgrade' runs:
  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Reset system to "fresh" state with '/persist/.reset-system':
  # boot.initrd.postDeviceCommands = lib.mkAfter ''
  #   DEV=/dev/disk/by-label/nixos
  #   mkdir -p /run/vol /run/persist

  #   # Mount top-level volume to manipulate snapshots, and the
  #   # '@persist' subvol to check for the '.reset-system' marker:
  #   mount -t btrfs -o subvol=/ "$DEV" /run/vol
  #   mount -t btrfs -o ro,subvol=@persist "$DEV" /run/persist

  #   if [ -f /run/persist/.reset-system ]; then
  #     echo "Resetting @root from @root-blank"

  #     # Delete nested subvolumes under @root first
  #     btrfs subvolume list -o /run/vol/@root | cut -f9 -d' ' | while read -r sv; do
  #       btrfs subvolume delete "/run/vol/$sv"
  #     done

  #     # Replace @root
  #     btrfs subvolume delete /run/vol/@root
  #     btrfs subvolume snapshot /run/vol/@root-blank /run/vol/@root
  #   else
  #     echo "Leaving @root unchanged"
  #   fi

  #   umount /run/persist
  #   umount /run/vol
  # '';

  # The folllowing directories will be persisted:
  environment.persistence."/persist" = {
    directories = [
      "/var/db" # Databases, sudo lecture, etc.
      "/var/lib" # Application & package manager state
      "/etc/nixos" # NixOS configuration
      "/home/dfurnes" # Home directory
      "/etc/NetworkManager/system-connections" # WiFi networks
    ];
  };

  # Bootloader:
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0; # hold 'space' to show menu.

  # Plymouth:
  boot.plymouth.enable = true;
  boot.plymouth.theme = "spinner";
  boot.initrd.systemd.enable = true;

  # Desktop environment:
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME Keyring:
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # User accounts:
  users.mutableUsers = false;
  users.users.dfurnes = {
    isNormalUser = true;
    description = "David Furnes";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = "/persist/secrets/dfurnes.hash";
    shell = pkgs.zsh; 
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPT03WzkjZo7eQlGCgP+kuvs3f4A/s6MoEbITrIChOv+ david@dfurnes.com"
    ];
    packages = with pkgs; [
      # ...
    ];
  };

  # Disable password login for root user:
  users.users.root.hashedPassword = "!";

  # OpenSSH server:
  services.openssh.enable = true;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
  };

  # Avahi (Bonjour):
  services.avahi = {
    enable = true;
    nssmdns4 = true; # .local name resolution on IPv4
    openFirewall = true; # allow 5353, etc.
    publish.enable = true;
    publish.userServices = true;
  };

  # Dropbox
  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
      ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  # Open ports in the firewall for SSH & Dropbox.
  networking.firewall.allowedTCPPorts = [ 22 17500 ];
  networking.firewall.allowedUDPPorts = [ 17500 ];

  # Graphics:
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Prevent Logitech mouse receiver from preventing sleep:
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="046d", ATTR{idProduct}=="c548", ATTR{power/wakeup}="disabled"
  '';

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

  # Default settings for stateful data (e.g. file locations or database versions),
  # based on first install. Do not change without validating compatibility!
  system.stateVersion = "25.11";
}
