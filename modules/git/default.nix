{config, ...}: {
  config = {
    xdg.configFile."git".source = ./config;

    home.file = {
      ".local/bin/git-credential-bw" = config.lib.file.mkExecutable ./git-credential-bw;
      ".local/bin/git-credential-op" = config.lib.file.mkExecutable ./git-credential-op;
      ".local/bin/git-user" = config.lib.file.mkExecutable ./git-user;
      ".local/bin/interactive-diff" = config.lib.file.mkExecutable ./interactive-diff;
    };
  };
}
