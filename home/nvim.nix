{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    neovim
    nodejs
    python3
    python3Packages.pip
    unzip
    gcc
    gnumake
    ripgrep
    fd
    cargo
  ];
}
