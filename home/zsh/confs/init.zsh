# Zsh Initialization - Managed by user in repository
# This file is sourced by the Nix-managed .zshrc bridge

# --- Aliases ---
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'

# --- fzf-tab Configuration ---
# Use eza --tree for directory previews
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:*' fzf-preview-window 'down:15:wrap'
zstyle ':fzf-tab:*' fzf-flags --height=70% --border
zstyle ':fzf-tab:complete:*' fzf-preview '
  if [[ -d $realpath ]]; then
      eza --tree --level=3 --icons $realpath
  elif [[ $realpath == *.(jpg|jpeg|png|gif|bmp|webp|tiff) ]]; then
      chafa -s ${FZF_PREVIEW_COLUMNS:-"$((COLUMNS/2))"}x${FZF_PREVIEW_LINES:-"$((LINES/2))"} "$realpath"
  else
      bat --style=numbers --color=always "$realpath" || cat "$realpath"
  fi'

# Keybinding for fzf-tab
bindkey "^I" fzf-tab-complete
