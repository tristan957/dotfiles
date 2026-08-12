{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.zsh.envExtra =
      # zsh
      ''
        if [ -f "${config.xdg.configHome}/op/service-account-token" ]; then
          export OP_SERVICE_ACCOUNT_TOKEN="$(cat "${config.xdg.configHome}/op/service-account-token")"
        fi
      '';

    programs.bash.profileExtra =
      lib.mkAfter
      # bash
      ''
        if [ -f "${config.xdg.configHome}/op/service-account-token" ]; then
          export OP_SERVICE_ACCOUNT_TOKEN="$(cat "${config.xdg.configHome}/op/service-account-token")"
        fi
      '';

    programs.fish.shellInit =
      # fish
      ''
        if test -f "${config.xdg.configHome}/op/service-account-token"
          set -gx OP_SERVICE_ACCOUNT_TOKEN (cat "${config.xdg.configHome}/op/service-account-token")
        end
      '';

    systemd.user.services."1password" = {
      Unit = {
        Description = "Start 1Password";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "1password --silent";
        Restart = "always";
      };
      Install.WantedBy = ["graphical-session.target"];
    };

    systemd.user.tmpfiles.rules = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
      "d %S/op 0700"
    ];
  };
}
