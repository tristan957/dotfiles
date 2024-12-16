---@module "lspconfig"

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
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
