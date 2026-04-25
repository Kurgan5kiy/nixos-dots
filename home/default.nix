{ inputs, vars, theme, pkgs, ... }:
let
  inherit (vars) username stateVersion;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars theme; };

    # Pass shared modules (like nix-index-database for comma)
    sharedModules = [
      inputs.nix-index-database.homeModules.nix-index
    ];

    users.${username} = {
      imports = [
        ./modules.nix
      ];

      home = {
        packages = with pkgs; [ nautilus ];
        inherit username stateVersion;
        homeDirectory = "/home/${username}";
      };

      xdg.enable = true;
    };
  };
}
