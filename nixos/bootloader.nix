{
  # Standard systemd-boot bootloader for Nix:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Hold "space" at boot to show boot menu:
  boot.loader.timeout = 0;
}
