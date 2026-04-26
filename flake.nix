{
  description = "Base system configuration & dotfiles.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

    home = {
      url = "path:./home";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, home, impermanence, ... }:
  let
    mkNixosSystem = { system, modules }:
      let
        pkgsUnstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
      in
      nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = { inherit pkgsUnstable self; };
      };
    mkDarwinSystem = { system, modules }:
      let
        pkgsUnstable = import nixpkgs-unstable { inherit system; };
      in
      nix-darwin.lib.darwinSystem {
        inherit system modules;
        specialArgs = { inherit pkgsUnstable self; };
      };
  in
  {
    darwinConfigurations."Davids-MacBook-Air" = mkDarwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./systems/macos/configuration.nix

        # Home Manager config lives in home/flake.nix and is exposed as
        # `home.users.dfurnes` in that flake's outputs. See home/flake.nix.
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dfurnes = home.users.dfurnes;
        }
      ];
    };

    nixosConfigurations.desktop = mkNixosSystem {
      system = "x86_64-linux";
      modules = [
        impermanence.nixosModules.impermanence
        ./systems/nixos/hardware-configuration.nix
        ./systems/nixos/configuration.nix

        # ./systems/nixos/bootloader.nix
        # ./systems/nixos/desktop.nix
        # ./systems/nixos/devices.nix
        # ./systems/nixos/nixos.nix
        # ./systems/nixos/packages.nix
        # ./systems/nixos/persistence.nix
        # ./systems/nixos/services.nix
        # ./systems/nixos/users.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dfurnes = home.users.dfurnes;
        }
      ];
    };
  };
}
