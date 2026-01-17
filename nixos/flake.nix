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
      # Add host-specific modules and hardware-configuration.nix here.
      # Example:
      # my-host = mkNixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/my-host/hardware-configuration.nix
      #     ({ pkgs, ... }: {
      #       nix.settings.experimental-features = "nix-command flakes";
      #       nixpkgs.config.allowUnfree = true;
      #     })
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.users.dfurnes = home.users.dfurnes;
      #     }
      #   ];
      # };
    };
  };
}
