{
  config,
  lib,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf config.modules.git.enable {
    xdg.configFile."git".source = ./config;

    home.file = {
      ".local/bin/git-credential-bw" = {
        source = ./git-credential-bw;
        executable = true;
      };
      ".local/bin/git-credential-op" = {
        source = ./git-credential-op;
        executable = true;
      };
      ".local/bin/git-user" = {
        source = ./git-user;
        executable = true;
      };
      ".local/bin/interactive-diff" = {
        source = ./interactive-diff;
        executable = true;
      };
    };
  };
}
