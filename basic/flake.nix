{
  description = "Basic NixOS flake, nothing advanced";

  # Inputs that flake accepts and uses
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixosbtw = lib.nixosSystem {
        system = "x86_64-linux";
        # Pass inputs and self to all modules
        specialArgs = { inherit self inputs; };
        modules = [
          ./system
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
