{ pkgs, ... }: {
  stylix = {
    enable = true;
    image = ../wallpapers/city-horizon.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
        name = "CaskaydiaCove Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
        name = "CaskaydiaCove Nerd Font";
      };
      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
        name = "CaskaydiaCove Nerd Font";
      };

      sizes = {
        applications = 12;
        terminal = 13;
        desktop = 11;
        popups = 11;
      };
    };

    # Auto-enable styling for all supported targets
    autoEnable = true;
    
    # Ensure some targets are specifically handled
    targets = {
      console.enable = true;
      grub.enable = true;
      gdm.enable = true;
    };
  };
}
