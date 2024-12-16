---@module "lspconfig"

local schemastore = require("schemastore")

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
return {
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
