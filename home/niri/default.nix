{ config, vars, ... }:
{
  # Writable Symlink to Repo
  xdg.configFile."niri".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/nixos-dots/home/niri/confs";
}
