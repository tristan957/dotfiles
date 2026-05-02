{
  config,
  lib,
  ...
}: {
  options.modules.kubernetes.enable = lib.mkEnableOption "kubernetes";

  config = lib.mkIf config.modules.kubernetes.enable {
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
  };
}
