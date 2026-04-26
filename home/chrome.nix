{ pkgs, ... }:
{
  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
      "--ozone-platform=wayland"
    ];
  };
}
