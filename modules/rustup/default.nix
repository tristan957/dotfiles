{
  config,
  pkgs,
  ...
}: {
  config = {
    home.sessionVariables = {
      RUSTUP_HOME = "${config.home.homeDirectory}/.opt/rustup";
    };

    # rustup ships a `bin/rust-analyzer` shim (along with cargo/rustc/etc.)
    # that dispatches to whatever toolchain component is active. That
    # collides with the standalone rust-analyzer package below, which we
    # want to win so rust-analyzer tracks nixpkgs' update cadence instead
    # of being pinned to whatever component rustup last installed.
    home.packages = [
      pkgs.rustup
    ];
  };
}
