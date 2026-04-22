{ vars, ... }:
{
  programs.git = {
    enable = true;
    settings = vars.git;
  };
}
