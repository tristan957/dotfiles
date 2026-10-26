{
  inputs,
  lib,
  pkgs,
  ...
}: let
  rex = inputs.rex.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  home.packages = [rex];

  # Per-user equivalent of the upstream NixOS module's `services.rex`, listening
  # on the default socket in $XDG_RUNTIME_DIR so the `rex` client finds it
  # without --server.
  systemd.user.services.rex = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Unit = {
      Description = "Rex Server";
      Documentation = "https://superlogical.com";
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe rex} server run";
      Environment = [
        "TERMINFO_DIRS=${rex}/share/terminfo:"
      ];
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install.WantedBy = ["default.target"];
  };
}
