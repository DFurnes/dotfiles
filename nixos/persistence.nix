{ config, lib, ... }:

{
  # Reset system to "fresh" state with '/persist/.reset-system':
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    DEV=/dev/disk/by-label/nixos
    mkdir -p /run/vol /run/persist

    # Mount top-level volume to manipulate snapshots, and the
    # '@persist' subvol to check for the '.reset-system' marker:
    mount -t btrfs -o subvol=/ "$DEV" /run/vol
    mount -t btrfs -o ro,subvol=@persist "$DEV" /run/persist

    if [ -f /run/persist/.reset-system ]; then
      echo "Resetting @root from @root-blank"

      # Delete nested subvolumes under @root first
      btrfs subvolume list -o /run/vol/@root | cut -f9 -d' ' | while read -r sv; do
        btrfs subvolume delete "/run/vol/$sv"
      done

      # Replace @root
      btrfs subvolume delete /run/vol/@root
      btrfs subvolume snapshot /run/vol/@root-blank /run/vol/@root
    else
      echo "Leaving @root unchanged"
    fi

    umount /run/persist
    umount /run/vol
  '';

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
}
