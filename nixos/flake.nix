{
  description = "NixOS system configuration & dotfiles.";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.follows = "nixpkgs-unstable";
    home-manager.follows = "home-manager";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "";
    impermanence.inputs.home-manager.follows = "";

    home = {
      url = "path:../home";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, nixpkgs-unstable, home, impermanence }:
  let
    mkNixosSystem = { system, modules }:
      nixpkgs.lib.nixosSystem {
        inherit system modules;
      };
  in
  {
    nixosConfigurations = {
       desktop = mkNixosSystem {
         system = "x86_64-linux";
         modules = [
           impermanence.nixosModules.impermanence
           ./hardware-configuration.nix

           # Configuration:
           ./bootloader.nix
           ./desktop.nix
           ./devices.nix
           ./nixos.nix
           ./packages.nix
           ./persistence.nix
           ./services.nix
           ./users.nix

           ({ pkgs, ... }: {
             # ...
           })
           home-manager.nixosModules.home-manager
           {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.users.dfurnes = home.users.dfurnes;
           }
         ];
       };
    };
  };
}
