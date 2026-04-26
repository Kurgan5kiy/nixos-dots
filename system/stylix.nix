{ pkgs, theme, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.current}.yaml";
    polarity = "dark";
    # image = ...
    targets.chromium.enable = false;
  };
}
