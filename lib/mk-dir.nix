# Helper for creating a directory during activation.
#
# Wired into config.lib in lib/mk-home.nix, so modules use it as:
#   { config, ... }: {
#     home.activation.createFooStateDir =
#       config.lib.activation.mkDir "${config.xdg.stateHome}/foo";
#   }
#
# Goes through home-manager's `run` wrapper, so `home-manager switch --dry-run`
# prints the command instead of actually creating the directory.
{lib}: dir:
lib.hm.dag.entryAfter ["writeBoundary"] ''
  run mkdir -p ${lib.escapeShellArg dir}
''
