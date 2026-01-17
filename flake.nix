{
  description = "Base system configuration & dotfiles.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    macos.url = "path:./macos";
    macos.inputs.nixpkgs.follows = "nixpkgs-darwin";
    macos.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    macos.inputs.home-manager.follows = "home-manager";

    nixos.url = "path:./nixos";
    nixos.inputs.nixpkgs.follows = "nixpkgs";
    nixos.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    nixos.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, macos, nixos, ... }:
  {
    darwinConfigurations = macos.darwinConfigurations;
    nixosConfigurations = nixos.nixosConfigurations;
  };
}
