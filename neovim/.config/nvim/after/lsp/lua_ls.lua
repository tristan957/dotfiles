---@module "lspconfig"

local xdg = require("tristan957.utils.xdg")

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
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
    if client.workspace_folders then
      local path = client.workspace_folders[1].name

      for _, file in ipairs({ ".luarc.json", ".luarc.jsonc" }) do
        if vim.uv.fs_stat(vim.fs.joinpath(path, file)) then
          return
        end
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      diagnostics = {
        globals = {
          "vim",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fs.joinpath(xdg.data_home(), "comlink", "lua"),
        },
      },
    })
  end,
}
