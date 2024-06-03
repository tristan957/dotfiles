local Path = require("plenary.path")
local utils = require("tristan957.lsp.utils")

return {
  cmd = { "lua-language-server" },
  root_dir = utils.root_dir({
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
  }),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        preloadFileSize = 200,
      },
    },
  },
  ---@param client vim.lsp.Client
  on_init = function(client)
    local path = Path:new(client.workspace_folders[1].name)

    if
        path:joinpath(".luarc.json"):exists()
        or path:joinpath(".luarc.jsonc"):exists()
    then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      globals = {
        "vim",
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
    })
  end,
}
