{ vars, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.git.user.name;
        email = vars.git.user.email;
      };
      init.defaultBranch = vars.git.defaultBranch;
      core.editor = vars.git.editor;
    };
  };
}
