local schemastore = require("schemastore")

---@type vim.lsp.Config
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
        unpack(schemastore.yaml.schemas()),
      },
    },
  },
}
