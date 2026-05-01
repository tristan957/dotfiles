{...}: {
  home.file = {
    ".local/bin/kubectl-setns" = {
      source = ./kubectl-setns;
      executable = true;
    };
    ".local/bin/kubectl-cc" = {
      source = ./kubectl-cc;
      executable = true;
    };
  };
}
