---@module "lspconfig"

local xdg = require("tristan957.utils.xdg")

---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      codeLens = {
        enable = true,
      },
      completion = {
        autoRequire = true,
        enable = true,
        keywordSnippet = "Both",
      },
      hint = {
        arrayIndex = "Auto",
        await = true,
        awaitPropagate = true,
        enable = true,
        paramName = "Literal",
        paramType = false,
        setType = false,
      },
      hover = {
        enable = true,
      },
      signatureHelp = {
        enable = true,
      },
      workspace = {
        library = {
          vim.fs.joinpath(xdg.data_home(), "comlink", "lua"),
        },
      },
    },
  },
}
