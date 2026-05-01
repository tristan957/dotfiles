---@module "lspconfig"

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.tinymist
  settings = {
    tinymist = {
      formatterMode = "typstyle",
    },
  },
}
