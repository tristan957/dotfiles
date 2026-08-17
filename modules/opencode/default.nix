{
  dotfilesPackages,
  mcp,
  pkgs,
  ...
}: {
  config = {
    programs.opencode = {
      enable = true;

      package = pkgs.symlinkJoin {
        inherit (pkgs.opencode) meta;
        name = "opencode-wrapped-${pkgs.opencode.version}";
        paths = [pkgs.opencode];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/opencode \
            --set OPENCODE_DISABLE_LSP_DOWNLOAD true
        '';
      };

      settings = {
        lsp = {};
        mcp = mcp.opencode.generate [
          mcp.servers._1password
          mcp.servers.fastmail
          mcp.servers.vercel
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
