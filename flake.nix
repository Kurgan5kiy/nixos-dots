{
  description = "Basic NixOS flake, nothing advanced";

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
      theme = import ./theme.nix;
    in {
    nixosConfigurations = {
      ${vars.hostName} = lib.nixosSystem {
        inherit (vars) system;
        specialArgs = { inherit self inputs vars theme; };
        modules = [
          ./system
          ./home # Imports your new modular home setup
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
