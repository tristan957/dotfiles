# Helpers for config that can optionally be symlinked out of the Nix store, so
# it can be edited in place without rebuilding.
#
# Used together:
#   { config, lib, ... }: let
#     cfg = config.modules.foo;
#     symlink = import ../../lib/symlink.nix { inherit lib; };
#   in {
#     options.modules.foo.symlink = symlink.mkOption "the foo config";
#     config.xdg.configFile."foo".source = symlink.select config cfg.symlink ./foo;
#   }
{lib}: {
  # Declares the option. `what` completes the sentence "Absolute path to
  # symlink <what> from ...".
  mkOption = what:
    lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Absolute path to symlink ${what} from for live editing
        (out-of-store symlink). Null uses the Nix store copy.
      '';
    };

  # Resolves the option to a file source, falling back to the store path.
  select = config: path: fallback:
    if path != null
    then config.lib.file.mkOutOfStoreSymlink path
    else fallback;
}
