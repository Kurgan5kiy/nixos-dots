{ self, inputs, ...}: {
  flake.nixosModules.noctalia = { pkgs, lib, ... }: {
    # Only the final, wrapped Noctalia gets installed system-wide!
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
    ];

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      acpid.enable = true;
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.myNoctalia = let

      myTessdata = pkgs.runCommand "my-tessdata" {} ''
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
        grim slurp wl-clipboard tesseract imagemagick zbar curl
        translate-shell wl-screenrec ffmpeg gifski jq
      ];

      baseNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings =
          (builtins.fromJSON
            (builtins.readFile ./noctalia.json)
          ).settings;
      };

    in pkgs.symlinkJoin {
      name = "noctalia-wrapped";
      paths = [ baseNoctalia ];
      buildInputs = [ pkgs.makeWrapper ];

      # Point TESSDATA_PREFIX directly to the inner folder, WITH a trailing slash!
      postBuild = ''
        wrapProgram $out/bin/noctalia-shell \
          --prefix PATH : ${lib.makeBinPath extraPackages} \
          --set TESSDATA_PREFIX ${myTessdata}/share/tessdata/
      '';

      meta.mainProgram = "noctalia-shell";
    };
  };
}
