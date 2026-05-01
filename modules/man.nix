{pkgs, ...}: {
  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  programs.man.enable = !pkgs.stdenv.isDarwin;
}
