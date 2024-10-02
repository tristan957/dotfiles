local capabilities = require("tristan957.lsp").capabilities
local default_config = require("lspconfig.configs.lemminx").default_config

return {
  capabilities = capabilities,
  filetypes = {
    "sgml",
    table.unpack(default_config.filetypes)
  },
}
