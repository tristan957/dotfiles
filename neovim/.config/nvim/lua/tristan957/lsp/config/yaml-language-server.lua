local capabilities = require("tristan957.lsp").capabilities
local schemastore = require("schemastore")

---@type lspconfig.Config
return {
  capabilities = capabilities,
  filetypes = {
    "yaml",
    "yaml.openapi",
  },
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schemastore.yaml.schemas(),
    },
  },
}
