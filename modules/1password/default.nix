{
  config,
  lib,
  ...
}: {
  options.modules."1password".enable = lib.mkEnableOption "1password";

  config = lib.mkIf config.modules."1password".enable {
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
  };
}
