{...}: {
  home.file = {
    ".local/bin/kubectl-setns" = {
      source = ../kubernetes/.local/bin/kubectl-setns;
      executable = true;
    };
    ".local/bin/kubectl-cc" = {
      source = ../kubernetes/.local/bin/kubectl-cc;
      executable = true;
    };
  };
}
