{
  description = "macOS system configuration & dotfiles.";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.follows = "nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.follows = "home-manager";

    home = {
      url = "path:../home";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, home }:
  let
    system = "aarch64-darwin";
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
    configuration = { pkgs, ... }: {
      imports = [
        ../modules/system-packages.nix
        ../modules/fonts.nix
      ];

      system.primaryUser = "dfurnes";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
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

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

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

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Allow non-free packages, like Claude Code:
      nixpkgs.config.allowUnfree = true;
    };

  in
  {
    darwinConfigurations."Davids-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        # Home Manager config lives in home/flake.nix and is exposed as
        # `home.users.dfurnes` in that flake's outputs. See home/flake.nix.
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dfurnes = home.users.dfurnes;
        }
      ];
    };
  };
}
