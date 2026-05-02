{
  config,
  lib,
  ...
}: {
  options.modules.work.enable = lib.mkEnableOption "work";

  config = lib.mkIf config.modules.work.enable {
    home.sessionPath = [
      "$HOME/.aim/mcp-servers"
      "$HOME/.toolbox/bin"
    ];

    home.file.".local/bin/mcurl" = {
      source = ./mcurl;
      executable = true;
    };
  };
}
