{ vars, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = vars.git.name;
        email = vars.git.email;
      };
      init.defaultBranch = vars.git.defaultBranch;
      core.editor = vars.git.editor;
    };
  };
}
