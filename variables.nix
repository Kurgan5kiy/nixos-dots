rec {
  username = "beholder"; #SETME
  hostName = "nixosbtw"; #SETME
  system = "x86_64-linux";
  stateVersion = "25.11";
  timeZone = "Europe/Warsaw"; #SETME

  dm.defaultSession = "niri";

  git = {
    user = {
      name = username; #SETME
      email = "kurganskiyvladislav@gmail.com"; #SETME
    };
    init.defaultBranch = "master"; #SETME
    core.editor = "nvim"; #SETME
  };

  xkb = {
    layout = "pl,ru"; #SETME
    options = "ctrl:swapcaps,grp:win_space_toggle"; #SETME
  };
  obsidian = {
    vaultName = "personal"; #SETME
    vault = "/home/${username}/Documents/obsidian/${obsidian.vaultName}"; #SETME
  };
}
