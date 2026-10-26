final: prev: {
  # Tell nix-flatpak to use the system flatpak
  flatpak = prev.writeShellScriptBin "flatpak" ''
    exec /usr/bin/flatpak "$@"
  '';
  pythonPackagesExtensions =
    prev.pythonPackagesExtensions
    ++ [
      (pyFinal: pyPrev: {
        # With `__structuredAttrs = true` (now the default for Python packages),
        # a list-valued `sphinxBuilders` becomes a bash array and sphinx-hook.sh
        # only sees its first element ("html"), so the "man" builder never runs
        # and the `man` output is left empty. A plain string works with the
        # hook's `eval`. Remove once fixed in nixpkgs.
        reuse = pyPrev.reuse.overridePythonAttrs {
          sphinxBuilders = "html man";
        };
      })
    ];
}
