{ vars, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = vars.username;
      user.email = vars.email;
      init.defaultBranch = "master";
      core.editor = "nvim";
    };
  };
}
