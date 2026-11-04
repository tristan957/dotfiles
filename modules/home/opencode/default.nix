{pkgs, ...}: {
  config = {
    programs.opencode = {
      enable = true;

      enableMcpIntegration = true;

      settings = {
        skills = ["${pkgs.hunk}/share/skills"];
      };

      cli = {
        keybinds = {
          "composer.shell.select" = "return,kpenter";
          "composer.subagent.select" = "return,kpenter";
          "composer.terminal.select" = "return,kpenter";
          "dialog.select.submit" = "return,kpenter";
          "dialog.prompt.submit" = "return,kpenter";
          "input.submit" = "return,kpenter";
          "plugins.toggle" = "return,kpenter";
          "prompt.autocomplete.select" = "return,kpenter";
        };
        session = {
          scrollbar = true;
        };
        theme = {
          name = "system";
          mode = "system";
        };
      };
    };
  };
}
