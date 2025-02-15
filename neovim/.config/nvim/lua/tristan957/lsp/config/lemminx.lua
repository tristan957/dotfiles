local default_config = require("lspconfig.configs.lemminx").default_config

---@type lspconfig.Config | {}
return {
  filetypes = {
    "sgml",
    table.unpack(default_config.filetypes)
  },
}
