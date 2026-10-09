{config, ...}: {
  config = {
    programs.cargo = {
      enable = true;

      # Keep package null so cargo continues to come from rustup.
      package = null;

      cargoHome = "${config.home.homeDirectory}/.opt/cargo";

      settings = {
        install.root = dirOf config.xdg.binHome;

        net = {
          # Given a more complex Git configuration, the Cargo Git library is
          # pretty naive. It doesn't resolve the config entirely. Use the Git
          # CLI to avoid any Git config problems.
          git-fetch-with-cli = true;
        };

        target = {
          x86_64-unknown-linux-gnu = {
            linker = "clang";
            rustflags = ["-C" "link-arg=-fuse-ld=mold"];
          };
        };
      };
    };
  };
}
