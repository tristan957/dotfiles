local schemastore = require("schemastore")

return {
  cmd = { "vscode-json-language-server", "--stdio" },
  init_options = {
    provideFormatter = true,
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
