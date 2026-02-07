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
          ];
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
