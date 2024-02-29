{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eww = {
      url = "github:ralismark/eww/tray-3";
      #url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs self pkgs-unstable;};
          modules = [ 
            ./hosts/vm/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };

    };
}
