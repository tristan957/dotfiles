local capabilities = require("tristan957.lsp").capabilities
local schemastore = require("schemastore")

return {
  capabilities = capabilities,
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
