{ inputs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username} = {
      imports = [ ./modules.nix ];
      home.username = vars.username;
      home.homeDirectory = "/home/${vars.username}";
      home.stateVersion = vars.stateVersion;
    };
  };
}
