{ vars, ... }:
{
  programs.obsidian = {
    enable = true;
    vaults = {
      "${vars.obsidian.vaultName}" = {
        target = "${vars.obsidian.vault}"; 
      };
    };
  };

  stylix.targets.obsidian = {
    enable = true;
    vaultNames = [ "${vars.obsidian.vaultName}" ];
  };
}
