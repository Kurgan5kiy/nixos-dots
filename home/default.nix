{ inputs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${vars.username} = {
      imports = [ 
        ./modules.nix
        inputs.spicetify-nix.homeManagerModules.default
      ];
      home.username = vars.username;
      home.homeDirectory = "/home/${vars.username}";
      home.stateVersion = vars.stateVersion;

      xdg = {
        enable = true;
        configHome = "/home/${vars.username}/.config";
      };

      gtk.gtk4.theme = null;
    };
  };
}
