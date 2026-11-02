final: prev: {
  # Tell nix-flatpak to use the system flatpak
  flatpak = prev.writeShellScriptBin "flatpak" ''
    exec /usr/bin/flatpak "$@"
  '';
}
