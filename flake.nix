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
      vars = import ./variables.nix;
    in {
    nixosConfigurations = {
      ${vars.hostname} = lib.nixosSystem {
        inherit (vars) system;
        # Pass inputs and self to all modules
        specialArgs = { inherit self inputs vars; };
        modules = [
          ./system
          ./home
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
