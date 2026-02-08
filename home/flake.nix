{
  description = "Home Manager configuration for dfurnes";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    home-manager.follows = "home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
  let
    userConfig = {pkgs, config, lib, ...}:
    let
      dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    in
    {
      home.stateVersion = "23.05";

      programs.home-manager.enable = true;

      home.packages = lib.optionals pkgs.stdenv.isLinux [
        pkgs.gcr
      ];

      services.gpg-agent = lib.mkIf pkgs.stdenv.isDarwin {
        enable = true;
        enableSshSupport = true;
        pinentry.package = pkgs.pinentry_mac;
      };

      services.gnome-keyring = lib.mkIf pkgs.stdenv.isLinux {
        enable = true;
        components = [ "pkcs11" "secrets" "ssh" ];
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      programs.git = {
        enable = true;
        settings = {
          user.name = "David Furnes";
          user.email = "david@dfurnes.com";
        };
      };

      home.file = {
        ".zshrc".source = ./zshrc;
        ".zprofile".source = ./zprofile;
	".npmrc" = {
	  text = "prefix = ~/.npm-packages";
        };
      } // (if pkgs.stdenv.isDarwin then {
        ".aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/mac/aerospace.toml";
      } else {
        ".dotfiles".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos";
      });

      xdg.configFile = {
        "nvim".source = ../nvim;
        "starship.toml".source = ./starship.toml;
      };

      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "Vitals@CoreCoding.com"
            "forge@jmmaranan.com"
          ];
        };
        
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [ ]; # Conflict: Super+1
          switch-to-application-2 = [ ]; # Conflict: Super+2
          switch-to-application-3 = [ ]; # etc.
          switch-to-application-4 = [ ];
          switch-to-application-5 = [ ];
          switch-to-application-6 = [ ];
          switch-to-application-7 = [ ];
          switch-to-application-8 = [ ];
          switch-to-application-9 = [ ];
        };

        "org/gnome/desktop/wm/keybindings" = {
          hide = [ ]; # Conflict: Super+H
          tile-left  = [ ]; # Conflict: Super+Left
          tile-right = [ ]; # Conflict: Super+Right

          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];

          move-to-workspace-1 = [ "<Shift><Super>1" ];
          move-to-workspace-2 = [ "<Shift><Super>2" ];
          move-to-workspace-3 = [ "<Shift><Super>3" ];
          move-to-workspace-4 = [ "<Shift><Super>4" ];
          move-to-workspace-5 = [ "<Shift><Super>5" ];
          move-to-workspace-6 = [ "<Shift><Super>6" ];
        };

        "org/gnome/mutter" = {
          # Steam games can be marked "unresponsive" w/ the default timeout:
          check-alive-timeout = lib.gvariant.mkUint32 15000;
        };

        "org/gnome/shell/extensions/forge" = {
          window-gap-size = 8;
        };

        "org/gnome/shell/extensions/forge/keybindings" = {
          window-focus-left = [ "<Super>h" ];
          window-focus-down = [ "<Super>j" ];
          window-focus-up = [ "<Super>k" ];
          window-focus-right = [ "<Super>l" ];

          window-move-left = [ "<Shift><Super>h" ];
          window-move-down = [ "<Shift><Super>j" ];
          window-move-up = [ "<Shift><Super>k" ];
          window-move-right = [ "<Shift><Super>l" ];

          con-split-layout-toggle = [ "<Super>slash" ];
          con-stacked-layout-toggle = [ "<Super>comma" ];

          window-toggle-float = [ "<Super>f" ];
        };
      };
    };
    in
    {
      users = {
        dfurnes = userConfig;
      };
    };
}
