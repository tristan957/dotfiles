local default_config = require("lspconfig.configs.lemminx").default_config

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
return {
  filetypes = {
    "sgml",
    table.unpack(default_config.filetypes)
  },
}
