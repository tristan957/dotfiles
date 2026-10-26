{
  dotfilesPackages,
  pkgs,
  ...
}: {
  config = {
    programs.opencode = {
      enable = true;

      enableMcpIntegration = true;

      settings = {
        skills = [
          "${dotfilesPackages.skills}/share/skills"
          "${pkgs.hunk}/share/skills"
        ];
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
