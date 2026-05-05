{
  config,
  lib,
  ...
}: {
  options.modules.extended-support.enable = lib.mkEnableOption "extended-support";

  config = lib.mkIf config.modules.extended-support.enable {
    home.sessionVariables = {
      OPS_EXTENDED_SUPPORT_DIR = "${config.home.homeDirectory}/Projects/work/postgresql-extended-support-ops";
      PGES_EXTENDED_SUPPORT_DIR = "${config.home.homeDirectory}/Projects/work/postgresql-extended-support";
    };

    programs.zsh.initContent = ''
      if [ -n "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
        export GITLAB_TOKEN="$(op read 'op://PostgreSQL Extended Support/GitLab Token/credential')"
      fi
    '';

    programs.bash.initExtra = ''
      if [ -n "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
        export GITLAB_TOKEN="$(op read 'op://PostgreSQL Extended Support/GitLab Token/credential')"
      fi
    '';

    programs.fish.interactiveShellInit = ''
      if set --query OP_SERVICE_ACCOUNT_TOKEN
        set -gx GITLAB_TOKEN (op read 'op://PostgreSQL Extended Support/GitLab Token/credential')
      end
    '';
  };
}
