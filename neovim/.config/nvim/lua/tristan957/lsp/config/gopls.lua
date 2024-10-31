local capabilities = require("tristan957.lsp").capabilities

---https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
---@type lspconfig.Config
return {
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
}
