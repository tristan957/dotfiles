--- https://github.com/microsoft/pyright/blob/main/docs/settings.md
---@type vim.lsp.Config
return {
  autostart = false,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  before_init = function(_, config)
    local poetry = require("tristan957.utils.poetry")
    local default_config = require("lspconfig.configs.pyright").default_config

    -- We are already in the virtual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1 then
      config.cmd = { "poetry", "run", "--", unpack(default_config.cmd) }
    end
  end,
}
