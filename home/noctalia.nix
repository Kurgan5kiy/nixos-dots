 { config, pkgs, lib, vars, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  tesseractWrapped = import ../wrapped/tesseract.nix { inherit pkgs lib; };
  
  extraPackages = with pkgs; [
    imagemagick
    grim
    slurp
    wl-clipboard
    tesseractWrapped
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

  # register noctalia as a native Systemd User Service
  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Desktop Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.bash}/bin/bash -lc 'noctalia-shell'";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # force Stylix to write directly to Noctalia's active color cache
  xdg.configFile."noctalia/colors.json" = {
    text = builtins.toJSON {
      mPrimary = colors.base0D;
      mOnPrimary = colors.base00;
      mSecondary = colors.base0E;
      mOnSecondary = colors.base00;
      mTertiary = colors.base0C;
      mOnTertiary = colors.base00;
      mError = colors.base08;
      mOnError = colors.base00;
      
      mSurface = colors.base00;
      mOnSurface = colors.base05;
      mSurfaceVariant = colors.base01;
      mOnSurfaceVariant = colors.base04;
      mOutline = colors.base03;
      mShadow = colors.base00;
      mHover = colors.base02;
      mOnHover = colors.base05;
    };

    onChange = ''
      ${pkgs.systemd}/bin/systemctl --user restart noctalia.service || true
    '';
  }; 
}
