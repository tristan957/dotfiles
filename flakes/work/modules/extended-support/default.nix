{config, ...}: {
  home.sessionVariables = {
    OPS_EXTENDED_SUPPORT_DIR = "${config.home.homeDirectory}/Projects/work/postgresql-extended-support-ops";
    PGES_EXTENDED_SUPPORT_DIR = "${config.home.homeDirectory}/Projects/work/postgresql-extended-support";
  };

  # No zsh equivalent: the only machine importing this module also imports
  # cloud-desktop, which execs into fish from the top of .zshrc, so anything
  # added here at the default order would never run.
  programs.bash.initExtra =
    # bash
    ''
      if [ -n "$OP_SERVICE_ACCOUNT_TOKEN" ]; then
        export GITLAB_TOKEN="$(op read 'op://PostgreSQL Extended Support/GitLab Token/credential')"
      fi
    '';

  programs.fish.interactiveShellInit =
    # fish
    ''
      if set --query OP_SERVICE_ACCOUNT_TOKEN
        set -gx GITLAB_TOKEN (op read 'op://PostgreSQL Extended Support/GitLab Token/credential')
      end
    '';
}
