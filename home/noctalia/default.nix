{ config, pkgs, lib, vars, ... }:
let
  tesseractWrapped = import ../../wrapped/tesseract.nix { inherit pkgs lib; };

  extraPackages = with pkgs; [
    imagemagick
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
  home = {
    packages = extraPackages;
  };
}
