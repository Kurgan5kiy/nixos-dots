{ pkgs, lib }:
let
  myTessdata = pkgs.runCommand "my-tessdata" { } ''
    mkdir -p $out/share

    # 1. Link all necessary config files, but EXCLUDE the 120+ default languages
    # We link them directly into $out/share
    for file in ${pkgs.tesseract}/share/tessdata/*; do
      if [[ $file != *.traineddata ]]; then
        ln -s "$file" $out/share/
      fi
    done

    # 2. Explicitly link the mandatory Orientation and Script Detection file
    ln -s ${pkgs.tesseract}/share/tessdata/osd.traineddata $out/share/

    # 3. Link ONLY the specific languages
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
