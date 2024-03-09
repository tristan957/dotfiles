local schemastore = require("schemastore")

return {
  cmd = { "yaml-language-server", "--stdio" },
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
