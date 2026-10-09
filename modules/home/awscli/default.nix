{pkgs, ...}: {
  config = {
    programs.awscli.enable = true;
    programs.awscli.package = pkgs.awscli2;
  };
}
