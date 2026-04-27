{ pkgs, inputs, ... }: 
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
    nodejs
    python3
    python3Packages.pip
    unzip
    gcc
    gnumake
    ripgrep
    fd
    cargo
    ascii-image-converter 
  ];

  xdg.desktopEntries."nvim" = {
    name = "Neovim Legacy";
    exec = "nvim %F";
    noDisplay = true;
  };
}
