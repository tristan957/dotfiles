{
  config,
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
        mcp = mcp.opencode.generate [mcp.servers.fastmail];
        skills = {
          paths = [
            "${config.home.homeDirectory}/dotfiles/skills"
            "${pkgs.hunk}/skills"
          ];
        };
      };

      tui.theme = "system";
    };
  };
}
