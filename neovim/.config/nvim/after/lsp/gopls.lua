--https://cs.opensource.google/go/x/tools/+/master:gopls/doc/

---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
