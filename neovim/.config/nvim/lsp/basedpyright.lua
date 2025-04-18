--- https://docs.basedpyright.com/dev/configuration/language-server-settings/
---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportUnusedCallResult = false,
        },
        useLibraryCodeForTypes = true,
      },
    },
  },
  before_init = function(_, config)
    local poetry = require("tristan957.utils.poetry")
    local default_config = require("lspconfig.configs.basedpyright").default_config

    -- We are already in the virual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1 then
      config.cmd = { "poetry", "run", "--", unpack(default_config.cmd) }
    end
  end,
}
