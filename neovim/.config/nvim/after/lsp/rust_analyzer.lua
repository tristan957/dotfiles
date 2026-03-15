---@module "lspconfig"

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        targetDir = true,
      },
      check = {
        command = "clippy",
      },
    },
  },
}
