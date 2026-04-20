{ pkgs, config, vars, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    
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

  # Writable Symlink to Repo for extra zsh configs like .p10k.zsh
  xdg.configFile."zsh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${vars.username}/nixos-dots/home/zsh/confs";
}
