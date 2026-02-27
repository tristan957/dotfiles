local schemastore = require("schemastore")

---@type vim.lsp.Config
return {
  filetypes = {
    "yaml",
    "yaml.openapi",
  },
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
