{
  stdenvNoCC,
  installAgentSkills,
}:
stdenvNoCC.mkDerivation {
  name = "skills";

  src = ../../skills;

  nativeBuildInputs = [installAgentSkills];

  dontConfigure = true;
  dontBuild = true;
  dontInstallAgentSkills = true;

  installPhase = ''
    runHook preInstall

    installSkill postgres-committer dotfiles

    runHook postInstall
  '';
}
