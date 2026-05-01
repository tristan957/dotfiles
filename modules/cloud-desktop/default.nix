{lib, ...}: {
  home.sessionVariables = {
    AWS_EC2_METADATA_DISABLED = "true";
    BRAZIL_WORKSPACE_DEFAULT_LAYOUT = "short";
    CLOUD_DESKTOP = "1";
  };

  # Exec into fish as soon as possible in Cloud Desktops
  programs.zsh.initContent = lib.mkBefore ''
    if command -v fish &>/dev/null; then
      exec env SHELL="$(which fish)" fish --login
    fi
  '';
}
