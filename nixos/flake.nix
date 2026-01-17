{
  description = "NixOS system configuration & dotfiles.";

  inputs = {
    nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.follows = "nixpkgs-unstable";

    home-manager.follows = "home-manager";

    home = {
      url = "path:../home";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, home-manager, nixpkgs, nixpkgs-unstable, home }:
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
           ./hardware-configuration.nix
           ./configuration.nix
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
