{ inputs, vars, ... }:
let
  inherit (vars) username stateVersion;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ./modules.nix
      ];
      home = {
        inherit username stateVersion;
        homeDirectory = "/home/${username}";
      };
      xdg.enable = true;
    };
  };
}
