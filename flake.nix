{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-fcitx5 = {
      url = "github:catppuccin/fcitx5";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [ inputs.neovim.overlay ];
    in
    {
    
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs self overlays;};
          modules = [ 
            ./hosts/vm/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };

      nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs self overlays;};
          modules = [ 
            ./hosts/tower/configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
        };

    };
}
