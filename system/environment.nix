{ pkgs, ... }:{
  environment = {
    systemPackages = with pkgs; [
      antigravity
      spotify
      telegram-desktop
      neovim
      wget
      git
      gh
      curl
      kitty
      alacritty
      brightnessctl
      pavucontrol
      bluetui
      zed-editor
      nautilus
      sushi
      wl-clipboard
      noctalia-shell
    ];

    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      GTK_THEME = "Adwaita:dark";
      EDITOR = "nvim";
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };
}
