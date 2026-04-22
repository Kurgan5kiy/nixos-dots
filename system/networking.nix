{ vars, ... }:
{
  networking = {
    inherit (vars) hostName;
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
