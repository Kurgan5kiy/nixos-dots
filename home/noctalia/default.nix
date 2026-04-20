{ config, pkgs, vars, ... }:
let
  myTessdata = pkgs.runCommand "my-tessdata" { } ''
    mkdir -p $out/share/tessdata

    # 1. Link all necessary config files, but EXCLUDE the 120+ default languages
    for file in ${pkgs.tesseract}/share/tessdata/*; do
      if [[ $file != *.traineddata ]]; then
        ln -s "$file" $out/share/tessdata/
      fi
    done

    # 2. Explicitly link the mandatory Orientation and Script Detection file
    ln -s ${pkgs.tesseract}/share/tessdata/osd.traineddata $out/share/tessdata/

    # 3. Link ONLY the specific languages you requested!
    ln -s ${pkgs.tesseract.languages.eng} $out/share/tessdata/eng.traineddata
    ln -s ${pkgs.tesseract.languages.rus} $out/share/tessdata/rus.traineddata
    ln -s ${pkgs.tesseract.languages.ukr} $out/share/tessdata/ukr.traineddata
    ln -s ${pkgs.tesseract.languages.pol} $out/share/tessdata/pol.traineddata
  '';

  extraPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    tesseract
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

  home.sessionVariables = {
    TESSDATA_PREFIX = "${myTessdata}/share/tessdata/";
  };

  # Writable Symlink to Repo for Noctalia-shell
  xdg.configFile."noctalia".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/nixos-dots/home/noctalia/confs";
}
