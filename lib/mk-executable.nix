# Helper for installing an executable file into the home directory.
#
# Wired into config.lib.file in lib/mk-home.nix, so modules use it as:
#   { config, ... }: {
#     home.file.".local/bin/foo" = config.lib.file.mkExecutable ./foo;
#   }
source: {
  inherit source;
  executable = true;
}
