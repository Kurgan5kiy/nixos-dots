{ pkgs, inputs, vars, ... }:
let
  inherit (vars) username stateVersion;
in
{
  imports = [
    ./modules.nix
  ];

  home = {
    packages = with pkgs; [
      nautilus
    ];
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };

  xdg.enable = true;

  # Standalone HM needs nixpkgs config set here
  nixpkgs.config.allowUnfree = true;

  # Let HM manage itself (installs the `home-manager` CLI)
  programs.home-manager.enable = true;
}
