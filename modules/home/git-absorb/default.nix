{pkgs, ...}: {
  config = {
    home.packages = [pkgs.git-absorb];

    programs.git.settings.absorb = {
      oneFixupPerCommit = false;
      autoStageIfNothingStaged = true;
    };
  };
}
