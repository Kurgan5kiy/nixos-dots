{ inputs, config, ... }:
let
  user = "beholder";
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${user} = {
      imports = [ ../home ];
      home.stateVersion = config.system.stateVersion;
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

}
