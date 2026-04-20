{ pkgs, vars, ... }:
{
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
