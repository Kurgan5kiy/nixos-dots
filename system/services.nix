{
    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      acpid.enable = true;

      displayManager = {
        gdm.enable = true;
        defaultSession = "niri";
      };
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      xserver.xkb = {
        layout = "pl,ru";
        options = "grp:win_space_toggle";
      };
    };
}