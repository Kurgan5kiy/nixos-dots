{ pkgs, theme, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.current}.yaml";
    # image = ./path/to/wallpaper.png; 
  };

  gtk.enable = true;

  # Force GTK4/Libadwaita (like Nautilus) to respect dark mode
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };

  # Expose your Home Manager themes so system apps (Thunar) can find them
  home.sessionVariables = {
    XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
  };
}
