{config, ...}: {
  config = {
    home.file = {
      ".local/bin/kubectl-cc" = config.lib.file.mkExecutable ./kubectl-cc;
      ".local/bin/kubectl-setns" = config.lib.file.mkExecutable ./kubectl-setns;
    };
  };
}
