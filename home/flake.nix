{
  description = "Home Manager configuration for dfurnes";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    home-manager.follows = "home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
  let
    userConfig = {pkgs, config, ...}:
    let
      dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
    in
    {
      home.stateVersion = "23.05";

      programs.home-manager.enable = true;

      services.gpg-agent = {
        enable = true;
        pinentry.package = if pkgs.stdenv.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
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
    };
  in
  {
    users = {
      dfurnes = userConfig;
    };
  };
}
