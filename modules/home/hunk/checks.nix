{
  lib,
  bun,
  stdenvNoCC,
  writableTmpDirAsHomeHook,
}: let
  src = ./extensions;

  # Only the manifest and lockfile decide what gets installed, so source edits
  # don't invalidate the fixed-output hash below.
  node_modules = stdenvNoCC.mkDerivation {
    name = "hunk-extensions-node_modules";

    src = lib.fileset.toSource {
      root = src;
      fileset = lib.fileset.unions [
        (src + "/package.json")
        (src + "/bun.lock")
      ];
    };

    impureEnvVars = lib.fetchers.proxyImpureEnvVars;

    nativeBuildInputs = [
      bun
      writableTmpDirAsHomeHook
    ];

    dontConfigure = true;

    # Optional dependencies are @opentui/core's per-platform native binaries,
    # which typechecking never loads. Omitting them keeps the output identical
    # on every system, so one hash covers them all.
    buildPhase = ''
      runHook preBuild

      export BUN_INSTALL_CACHE_DIR=$(mktemp -d)
      bun install \
        --frozen-lockfile \
        --ignore-scripts \
        --no-progress \
        --omit=optional

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      cp -R node_modules $out

      runHook postInstall
    '';

    # Patching shebangs would add store references, which fixed-output
    # derivations may not contain.
    dontFixup = true;

    outputHash = "sha256-tsaoCPUT1Yb9DNXaSOfhJrwJDbrsiHqTQIo611jRQYc=";
    outputHashMode = "recursive";
  };
in
  stdenvNoCC.mkDerivation {
    name = "hunk-extensions-check";
    inherit src;

    nativeBuildInputs = [
      bun
      writableTmpDirAsHomeHook
    ];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild

      # Copied rather than linked: TypeScript resolves symlinks, and type
      # references from inside a bare store path can't find their siblings.
      cp -R ${node_modules} node_modules
      bun node_modules/typescript/bin/tsc -p .
      bun test

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      touch $out

      runHook postInstall
    '';
  }
