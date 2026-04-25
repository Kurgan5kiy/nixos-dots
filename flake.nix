{
  description = "Basic NixOS flake, nothing advanced";

  # Inputs that flake accepts and uses
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      vars = import ./variables.nix;
    in {
    nixosConfigurations = {
      ${vars.hostName} = lib.nixosSystem {
        inherit (vars) system;
        specialArgs = { inherit self inputs vars; };
        modules = [
          ./system
          inputs.stylix.nixosModules.stylix
        ];
      };
    };

    homeConfigurations = {
      ${vars.username} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${vars.system};
        extraSpecialArgs = { inherit inputs vars; };
        modules = [
          ./home
          # inputs.stylix.homeModules.stylix
          inputs.nix-index-database.homeModules.nix-index
        ];
      };
    };
  };
}
