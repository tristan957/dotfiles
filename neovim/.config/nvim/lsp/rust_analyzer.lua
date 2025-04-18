---@type vim.lsp.Config
return {
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
