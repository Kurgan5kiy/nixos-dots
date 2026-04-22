{ vars, ... }:
{
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
    acpid.enable = true;

    displayManager = {
      gdm.enable = true;
      inherit (vars.dm) defaultSession;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      inherit (vars) xkb;
    };
  };
}
