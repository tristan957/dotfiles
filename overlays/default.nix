final: prev: {
  # Tell nix-flatpak to use the system flatpak
  flatpak = prev.writeShellScriptBin "flatpak" ''
    exec /usr/bin/flatpak "$@"
  '';

  # nixpkgs' fixed-output hash for opencode's node_modules is stale.
  opencode = prev.opencode.overrideAttrs (old: {
    node_modules = old.node_modules.overrideAttrs {
      outputHash = "sha256-prx9dX7kUvs/E3zopkaPk5LXh3xJAy5sZeum/W8L7cA=";
    };
  });
}
