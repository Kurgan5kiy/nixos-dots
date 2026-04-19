{
  programs.git = {
    enable = true;
    settings = {
      user.name = "beholder";
      user.email = "kurganskiyvladislav@gmail.com";
      init.defaultBranch = "master";
      core.editor = "nvim";
    };
  };
}
