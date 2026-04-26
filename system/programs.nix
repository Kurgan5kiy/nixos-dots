{
  programs = {
    zsh.enable = true;
    niri.enable = true;
    nix-ld.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [{
        settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      }];
    };
  };

}
