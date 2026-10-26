{pkgs, ...}: {
  config = {
    programs.opencode = {
      enable = true;

      enableMcpIntegration = true;

      settings = {
        skills = ["${pkgs.hunk}/share/skills"];
      };

      cli = {
        keybinds."input.submit" = "return,kpenter";
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
