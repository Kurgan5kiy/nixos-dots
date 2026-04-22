{ pkgs, ... }:
{
  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };
}
