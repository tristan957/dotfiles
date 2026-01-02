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
      schemas = schemastore.yaml.schemas({
        extra = {
          {
            description = "Container Compose Support",
            fileMatch = {
              "container-compose.yml",
              "container-compose.yaml",
            },
            name = "Container Compose",
            url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
          },
        },
      }),
    },
  },
}
