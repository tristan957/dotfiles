---@module "lspconfig"

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
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
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "comlink"),
        },
      },
    })
  end,
}
