{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    nvimconf = {
      url = "github:Skadic/nvim";
      flake = false;
    };

    dots = {
      url = "github:Skadic/dots";
      flake = false;
    };

    sway_update = {
      url = "github:Skadic/sway_update";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
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
