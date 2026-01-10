{
  description = "Base system configuration & dotfiles.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable }:
  let
    system = "aarch64-darwin";
    pkgsUnstable = import nixpkgs-unstable { inherit system; };
    configuration = { pkgs, ... }: {
      system.primaryUser = "dfurnes";

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        # aerospace
        doctl
        fzf
        git
        gnupg
        hub
        jq
        neovim
        nix-prefetch-github
        nodenv
        orbstack
        pinentry_mac
        silver-searcher
        squashfsTools
        starship 
        vfkit
        wget
        yt-dlp

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

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        jetbrains-mono
      ];
    };

    userConfig = {pkgs, config, ...}:
    let
      dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    in
    {
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;

      services.gpg-agent = {
        enable = true;

        # Connects gpg-agent to the nix-managed pinentry, allowing the
        # gpg key's passphrase to be stored in the login keychain:
        pinentry.package = pkgs.pinentry_mac;
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      home.file = {
        ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zsh/zshrc";
        ".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zsh/zshenv";
        ".zprofile".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/zsh/zprofile";
        ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/vim/vimrc";
        ".aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/mac/aerospace.toml";
      };

      xdg.configFile = {
      	"nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
      };
    };
  in
  {
    darwinConfigurations."Davids-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dfurnes = userConfig;
        }
      ];
    };
  };
}
