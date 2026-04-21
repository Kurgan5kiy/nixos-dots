{ inputs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username} = {
      imports = [
        ./modules.nix
      ];
      home = {
        username = vars.username;
        homeDirectory = "/home/${vars.username}";
        stateVersion = vars.stateVersion;
      };
      xdg = {
        enable = true;
        configHome = "/home/${vars.username}/.config";
      };
    };
  };
}
