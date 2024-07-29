local capabilities = require("tristan957.lsp").capabilities
local xdg = require("tristan957.xdg")

return {
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
  capabilities = capabilities,
  ---@param client vim.lsp.Client
  on_init = function(client)
    local path = client.workspace_folders[1].name

    for _, file in ipairs({ ".luarc.json", ".luarc.jsonc" }) do
      if vim.uv.fs_stat(vim.fs.joinpath(path, file)) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      diagnostics = {
        globals = {
          "vim",
        },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fs.joinpath(xdg.data_home(), "comlink"),
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
    })
  end,
}
