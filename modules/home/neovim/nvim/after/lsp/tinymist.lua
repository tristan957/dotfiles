---@module "lspconfig"

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.tinymist
  settings = {
    tinymist = {
      formatterMode = "typstyle",
      rootPath = vim.fs.root(0, ".git") or vim.uv.cwd(),
    },
  },
}
