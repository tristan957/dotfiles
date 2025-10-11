---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = { "testing" },
      },
      check = {
        command = "clippy",
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
