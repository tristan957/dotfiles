local schemastore = require("schemastore")

---@type vim.lsp.Config
return {
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
