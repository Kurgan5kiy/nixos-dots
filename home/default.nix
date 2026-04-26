{ inputs, vars, theme, pkgs, ... }:
let
  inherit (vars) username stateVersion;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars theme; };

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

      gtk = {
        enable = true;
        gtk4.theme = null;
      };

      xdg.enable = true;
    };
  };
}
