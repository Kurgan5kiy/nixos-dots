{ config, pkgs, lib, vars, ... }:
let
  tesseractWrapped = import ../../wrapped/tesseract.nix { inherit pkgs lib; };

  extraPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    tesseractWrapped
    imagemagick
    zbar
    curl
    translate-shell
    wl-screenrec
    ffmpeg
    gifski
    jq
    playerctl
    brightnessctl
  ];
in
{
  home.packages = extraPackages;

  # Writable Symlink to Repo for Noctalia-shell
  xdg.configFile."noctalia".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/nixos-dots/home/noctalia/confs";
}
