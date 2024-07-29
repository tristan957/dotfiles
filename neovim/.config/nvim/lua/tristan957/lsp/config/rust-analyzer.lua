local capabilities = require("tristan957.lsp").capabilities

return {
  capabilities = capabilities,
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
