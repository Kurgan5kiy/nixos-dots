{ pkgs, ... }:{
  environment = {
    systemPackages = with pkgs; [
      nixd
      antigravity
      spotify
      telegram-desktop
      wget
      git
      gh
      curl
      brightnessctl
      pavucontrol
      bluetui
      zed-editor
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
