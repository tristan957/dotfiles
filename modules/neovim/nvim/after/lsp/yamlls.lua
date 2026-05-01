---@module "lspconfig"

local schemastore = require("schemastore")

---@type vim.lsp.Config
return {
  filetypes = {
    "yaml",
    "yaml.openapi",
  },
  ---@type lspconfig.settings.yamlls
  settings = {
    yaml = {
      kubernetesCRDStore = {
        enable = true,
      },
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schemastore.yaml.schemas(),
    },
  },
}
