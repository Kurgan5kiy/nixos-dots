{
  description = "Basic NixOS flake, nothing advanced";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

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
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  outputs = { self, nixpkgs, nixpkgs-python, ... }@inputs:
    let
      lib = nixpkgs.lib;
      vars = import ./variables.nix;
      theme = import ./theme.nix;
      pkgs = nixpkgs.legacyPackages.${vars.system};
      py3143 = nixpkgs-python.packages.${vars.system}."3.14.3"; 
    in {
    nixosConfigurations = {
      ${vars.hostName} = lib.nixosSystem {
        inherit (vars) system;
        specialArgs = { inherit self inputs vars theme; };
        modules = [
          ./system
          ./home
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };

    devShells.${vars.system} = {
      default = pkgs.mkShell {
        packages = [
          py3143
          pkgs.poetry
          pkgs.uv
        ];

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
        ];

        shellHook = ''
          export POETRY_VIRTUALENVS_IN_PROJECT=true
          export UV_PROJECT_ENVIRONMENT=$PWD/.venv
          echo "Using exact Python version: $(python --version)"
        '';
      };
    };
  };
}
