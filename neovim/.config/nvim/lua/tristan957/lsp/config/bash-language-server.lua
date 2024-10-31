local capabilities = require("tristan957.lsp").capabilities

---@type lspconfig.Config
return {
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
    },
  },
}
