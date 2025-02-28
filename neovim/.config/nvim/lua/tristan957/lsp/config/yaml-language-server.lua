---@module "lspconfig"

local schemastore = require("schemastore")

---@type lspconfig.Config | {}
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
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "container-compose.yml",
          "container-compose.yaml",
        },
        table.unpack(schemastore.yaml.schemas()),
      },
    },
  },
}
