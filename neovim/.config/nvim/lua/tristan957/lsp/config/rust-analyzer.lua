local utils = require("tristan957.lsp.utils")

return {
  cmd = { "rust-analyzer" },
  root_dir = utils.root_dir({ "Cargo.toml", "rust-project.json" }),
  settings = {
    ["rust-analyzer"] = {
      check = {
        extraArgs = {
          "--target-dir=target/analyzer",
        },
      },
      server = {
        extraEnv = {
          CARGO_TARGET_DIR = "target/analyzer",
        },
      },
    },
  },
}
