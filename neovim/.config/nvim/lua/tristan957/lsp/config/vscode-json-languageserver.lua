local capabilities = require("tristan957.lsp").capabilities
local schemastore = require("schemastore")

return {
  capabilities = capabilities,
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
