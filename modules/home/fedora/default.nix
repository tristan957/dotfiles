# Use Fedora's packages instead of Nix's for software installed through dnf
# (see bootstrap/fedora/packages/install.txt). Modules still provide their
# configuration.
#
# Everything is set with mkDefault so a machine can take a single package from
# Nix after all, e.g. `dotfiles.neovim.package = pkgs.neovim;`.
{
  lib,
  options,
  ...
}: let
  # Only touch modules that are actually imported, as their options do not
  # exist otherwise.
  nullPackages = path: names:
    lib.genAttrs (builtins.filter (name: lib.hasAttrByPath [path name "package"] options) names) (_: {
      package = lib.mkDefault null;
    });
in {
  config = {
    programs =
      nullPackages "programs" [
        "git"
        "go"
        "jujutsu"
      ]
      // {
        # programs.gh.package is not nullable, so gh is switched off instead.
        # Priority 900 beats the mkDefault in the github module while still
        # letting a machine override it with a plain assignment.
        gh.enable = lib.mkOverride 900 false;
      };

    dotfiles = nullPackages "dotfiles" [
      "gdb"
      "glow"
      "hut"
      "just"
      "meson"
      "neovim"
      "node"
      "vim"
    ];
  };
}
