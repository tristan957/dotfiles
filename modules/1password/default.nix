{
  config,
  lib,
  ...
}: {
  options.modules."1password".enable = lib.mkEnableOption "1password";

  config = lib.mkIf config.modules."1password".enable {
    programs.zsh.envExtra = ''
      if [ -f "$XDG_CONFIG_HOME/op/service-account-token" ]; then
        export OP_SERVICE_ACCOUNT_TOKEN="$(cat "$XDG_CONFIG_HOME/op/service-account-token")"
      fi
    '';

    programs.bash.profileExtra = lib.mkAfter ''
      if [ -f "$XDG_CONFIG_HOME/op/service-account-token" ]; then
        export OP_SERVICE_ACCOUNT_TOKEN="$(cat "$XDG_CONFIG_HOME/op/service-account-token")"
      fi
    '';

    programs.fish.shellInit = ''
      if test -f "$XDG_CONFIG_HOME/op/service-account-token"
        set -gx OP_SERVICE_ACCOUNT_TOKEN (cat "$XDG_CONFIG_HOME/op/service-account-token")
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

    systemd.user.tmpfiles.rules = [
      "d %S/op 0700"
    ];
  };
}
