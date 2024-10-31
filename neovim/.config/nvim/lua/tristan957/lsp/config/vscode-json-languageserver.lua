local capabilities = require("tristan957.lsp").capabilities
local schemastore = require("schemastore")

---@type lspconfig.Config
return {
  capabilities = capabilities,
  filetypes = {
    "json",
    "json.openapi",
  },
  settings = {
    json = {
      schemas = schemastore.json.schemas({
        extras = {
          {
            name = "LuaLS Settings",
            url = "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json",
            fileMatch = { ".luarc.json", ".luarc.jsonc" },
          },
        },
      }),
      validate = {
        enable = true,
      },
    },
  },
}
