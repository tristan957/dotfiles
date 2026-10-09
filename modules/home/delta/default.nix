{pkgs, ...}: {
  config = {
    programs.delta = {
      enable = true;

      # https://dandavison.github.io/delta/
      options = {
        hyperlinks = true;
        hyperlinks-file-link-format = "{path}:{line}";
        navigate = true;
        side-by-side = true;
        tabs = 4;
        unobtrusive-line-numbers = true;

        dark.syntax-theme = "OneHalfDark";
        light.syntax-theme = "OneHalfLight";
      };

      # Wrap it such that we can have auto detecting dark/light mode
      package = pkgs.symlinkJoin {
        name = "delta-${pkgs.delta.version}";
        paths = [pkgs.delta];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/delta \
            --run 'case "$(appearance 2>/dev/null)" in
            light) export DELTA_FEATURES=light ;;
            dark) export DELTA_FEATURES=dark ;;
          esac'
        '';
      };
    };
  };
}
