# A small package exposing this repo's `skills/` directory from the Nix
# store, so consumers (e.g. the opencode module) can reference
# `${dotfilesPackages.skills}/skills` instead of assuming the repo is
# checked out at a particular path on disk. Mirrors the `$out/skills`
# symlink convention used by the `hunk` package in nixpkgs.
{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  name = "skills";

  src = ../../skills;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/dotfiles"
    cp -R . "$out/share/dotfiles/skills"
    ln -s share/dotfiles/skills "$out/skills"

    runHook postInstall
  '';
}
