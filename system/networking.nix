{ vars }: {
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
