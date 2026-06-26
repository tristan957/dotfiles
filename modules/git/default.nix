{config, ...}: {
  config = {
    xdg.configFile."git".source = ./config;

    home.file = {
      "${config.xdg.binHome}/git-credential-bw" = config.lib.file.mkExecutable ./git-credential-bw;
      "${config.xdg.binHome}/git-credential-op" = config.lib.file.mkExecutable ./git-credential-op;
      "${config.xdg.binHome}/git-user" = config.lib.file.mkExecutable ./git-user;
      "${config.xdg.binHome}/interactive-diff" = config.lib.file.mkExecutable ./interactive-diff;
    };
  };
}
