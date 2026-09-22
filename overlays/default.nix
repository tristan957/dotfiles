final: prev: {
  # Skip pre-commit's upstream test suite: it exercises language runtimes
  # (dotnet, coursier/JVM, go, rust, ...) we don't use, and pulls in a
  # dotnet-sdk build that's currently broken on aarch64-darwin (nixpkgs
  # regression building dotnet-stage0-vmr).
  #
  # Note: pre-commit is a Python package, and buildPythonPackage always
  # forces `doCheck = false` and instead runs the test suite via
  # `doInstallCheck` (remapping `nativeCheckInputs` into
  # `nativeInstallCheckInputs`), so `doInstallCheck` (not `doCheck`) is the
  # actual gate for those inputs. Additionally, `preCheck` unconditionally
  # string-interpolates the dotnet-sdk store path (to set $DOTNET_ROOT)
  # regardless of doCheck/doInstallCheck, which alone creates a hard build
  # dependency - so that must be cleared too. Finally, pytest-check-hook.sh
  # unconditionally appends `pytestCheckPhase` to `preDistPhases` (which
  # always runs, unlike checkPhase/installCheckPhase) unless
  # `dontUsePytestCheck` is set, so that's needed as well.
  pre-commit = prev.pre-commit.overrideAttrs (_: {
    doInstallCheck = false;
    dontUsePytestCheck = true;
    preCheck = "";
  });
}
