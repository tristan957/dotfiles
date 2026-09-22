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
      package = let
        unwrapped = pkgs.delta;
      in
        pkgs.symlinkJoin {
          name = "delta-${unwrapped.version}";
          paths = [unwrapped];
          postBuild = ''
            rm -f $out/bin/delta
            cat > $out/bin/delta <<'EOF'
            #!/bin/sh
            case "$(appearance 2>/dev/null)" in
            light) export DELTA_FEATURES=light ;;
            dark) export DELTA_FEATURES=dark ;;
            esac
            exec ${unwrapped}/bin/delta "$@"
            EOF
            chmod +x $out/bin/delta
          '';
        };
    };
  };
}
