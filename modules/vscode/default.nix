{
  config,
  lib,
  ...
}: {
  options.modules.vscode.enable = lib.mkEnableOption "vscode";

  config = lib.mkIf config.modules.vscode.enable {
    xdg.configFile."vscode-nvim".source = ./vscode-nvim;
  };
}
