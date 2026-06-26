{config, ...}: {
  config = {
    home.file = {
      "${config.xdg.binHome}/kubectl-cc" = config.lib.file.mkExecutable ./kubectl-cc;
      "${config.xdg.binHome}/kubectl-setns" = config.lib.file.mkExecutable ./kubectl-setns;
    };
  };
}
