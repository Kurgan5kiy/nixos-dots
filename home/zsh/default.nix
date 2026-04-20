{ pkgs, config, vars, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;
    
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    initContent = ''
      # Source p10k config if it exists
      [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
      
      # Conditional bridge to manual repo config
      # Allows you to edit init.zsh in your repo without nix-rebuild
      [[ -f ~/.config/zsh/init.zsh ]] && source ~/.config/zsh/init.zsh
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };

  home.packages = with pkgs; [
    zsh-completions
    bat
    chafa
  ];

  # Safer individual file links to prevent repo clobbering
  xdg.configFile = let
    confPath = "/home/${vars.username}/nixos-dots/home/zsh/confs";
    mkLink = path: config.lib.file.mkOutOfStoreSymlink "${confPath}/${path}";
  in {
    "zsh/init.zsh".source = mkLink "init.zsh";
    "zsh/.p10k.zsh".source = mkLink ".p10k.zsh";
  };
}
