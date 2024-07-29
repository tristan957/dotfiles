local capabilities = require("tristan957.lsp").capabilities

return {
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
    },
  },
}
