{ pkgs, ... }:{
  environment = {
    systemPackages = with pkgs; [
      nixd
      antigravity
      spotify
      telegram-desktop
      neovim
      wget
      git
      gh
      curl
      # kitty
      brightnessctl
      pavucontrol
      bluetui
      zed-editor
      # nautilus
      sushi
      wl-clipboard
      noctalia-shell
      comma
    ];

    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };
  };
}
