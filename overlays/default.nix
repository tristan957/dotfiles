final: prev: {
  # https://github.com/NixOS/nixpkgs/issues/563241
  # Remove once the fix has landed in nixpkgs.
  opencode = prev.opencode.overrideAttrs (old: {
    postPatch =
      (old.postPatch or "")
      + ''
        # fix for bun 1.4.x
        substituteInPlace packages/opencode/script/build.ts \
          --replace-fail 'splitting: true,' 'splitting: false,'
      '';
  });
}
