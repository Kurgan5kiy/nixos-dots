{ pkgs, lib }:
let
  myTessdata = pkgs.runCommand "my-tessdata" { } ''
    mkdir -p $out/share

    # link all necessary config files, but EXCLUDE the 120+ default languages
    # link directly into $out/share
    for file in ${pkgs.tesseract}/share/tessdata/*; do
      if [[ $file != *.traineddata ]]; then
        ln -s "$file" $out/share/
      fi
    done

    # explicitly link the mandatory Orientation and Script Detection file
    ln -s ${pkgs.tesseract}/share/tessdata/osd.traineddata $out/share/

    # link ONLY the specific languages
    ln -s ${pkgs.tesseract.languages.eng} $out/share/eng.traineddata
    ln -s ${pkgs.tesseract.languages.rus} $out/share/rus.traineddata
    ln -s ${pkgs.tesseract.languages.ukr} $out/share/ukr.traineddata
    ln -s ${pkgs.tesseract.languages.pol} $out/share/pol.traineddata
  '';
in
pkgs.symlinkJoin {
  name = "tesseract-wrapped";
  paths = [ pkgs.tesseract ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/tesseract \
      --set TESSDATA_PREFIX "${myTessdata}/share"
  '';
}
