{
  dotfilesPackages,
  pkgs,
  lib,
  ...
}: let
  mcp = import ../../lib/mcp {inherit lib;};
in {
  config = {
    programs.opencode = {
      enable = true;

      settings = {
        mcp = mcp.opencode.generate [
          mcp.servers._1password
          mcp.servers.fastmail
        ];
        skills = {
          paths = [
            "${dotfilesPackages.skills}/skills"
            "${pkgs.hunk}/skills"
          ];
        };
      };

      tui = {
        keybinds = {
          input_submit = "return,kpenter";
        };
        theme = "system";
      };
    };
  };
}
