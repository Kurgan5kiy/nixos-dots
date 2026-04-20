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
  # Individual Writable Symlinks to Repo for Noctalia-shell
  # This allows us to manage colors.json via Nix/Stylix while keeping others editable
  xdg.configFile = let
    confPath = "/home/${vars.username}/nixos-dots/home/noctalia/confs";
    mkLink = path: config.lib.file.mkOutOfStoreSymlink "${confPath}/${path}";
  in {
    "noctalia/settings.json".source = mkLink "settings.json";
    "noctalia/plugins.json".source = mkLink "plugins.json";
    "noctalia/user-templates.toml".source = mkLink "user-templates.toml";
    "noctalia/plugins".source = mkLink "plugins";
    "noctalia/colorschemes".source = mkLink "colorschemes";
    
    "noctalia/colors.json".text = with config.lib.stylix.colors.withHashtag; builtins.toJSON {
      mError = base08;
      mHover = base02;
      mOnError = base00;
      mOnHover = base05;
      mOnPrimary = base00;
      mOnSecondary = base00;
      mOnSurface = base05;
      mOnSurfaceVariant = base04;
      mOnTertiary = base00;
      mOutline = base03;
      mPrimary = base0D;
      mSecondary = base0C;
      mShadow = base00;
      mSurface = base00;
      mSurfaceVariant = base01;
      mTertiary = base0B;
    };
  };
}
