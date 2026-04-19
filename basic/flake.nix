{
  description = "Basic NixOS flake, nothing advanced";

  # Inputs that flake accepts and uses
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, lib, ... }{
    nixosConfigurations = {
      neobehier = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
