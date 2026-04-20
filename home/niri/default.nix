{ config, vars, ... }:
{
  xdg.enable = true;
  # Set base config directory for user to ~/.config
  xdg.configHome = "/home/${vars.username}/.config";

  # Writable Symlink to Repo
  xdg.configFile."niri".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/nixos-dots/home/niri/confs";
}
