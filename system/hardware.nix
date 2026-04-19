{ pkgs, ... }:
{
  hardware = {
    bluetooth.enable = true;
    # Ensure graphics and Intel drivers are enabled
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };
}
