{ pkgs, self, ... }:

{
  imports = [
    ../modules/defaults.nix
    ../modules/system-packages.nix
    ../modules/fonts.nix
  ];

  # To search: `nix-env -qaP | grep wget`
  environment.systemPackages = with pkgs; [
    # git/gpg:
    pinentry_mac

    # virtual machines
    orbstack
    vfkit

    # unstable:
    pkgsUnstable.aerospace
  ];

  # Enable Touch ID for 'sudo':
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;

  # Users:
  system.primaryUser = "dfurnes";
  users.users.dfurnes = {
    home = "/Users/dfurnes";
  };

  # Determinate uses its own daemon to manage the Nix installation that
  # conflicts with nix-darwin’s native Nix management:
  nix.enable = false;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # macOS defaults:
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;

    finder.FXPreferredViewStyle = "clmv"; # columns
      finder.ShowExternalHardDrivesOnDesktop = true;
    finder.ShowRemovableMediaOnDesktop = true;

    WindowManager.EnableStandardClickToShowDesktop = false;

    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
