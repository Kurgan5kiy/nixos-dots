{ pkgs, lib, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-gnome 
    ];
    config = {
      common.default = [ "gtk" ];
      niri = {
        default = lib.mkForce [ "gtk" ];
        "org.freedesktop.impl.portal.Screencast" = lib.mkForce [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = lib.mkForce [ "gnome" ];
        "org.freedesktop.impl.portal.Secret" = lib.mkForce [ "gnome-keyring" ];
      };
    };
  };
}
