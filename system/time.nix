{ vars, ... }:
{
  time = {
    inherit (vars) timeZone;
    hardwareClockInLocalTime = true;
  };
}
