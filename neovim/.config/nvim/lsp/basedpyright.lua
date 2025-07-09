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
    python = {},
  },
  before_init = function(_, config)
    -- We are already in the virtual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    local poetry = require("tristan957.utils.poetry")

    if
      poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1
    then
      local python_exe = poetry.python_executable()
      if python_exe ~= nil then
        config.settings.python["pythonPath"] = poetry.python_executable()
      else
        vim.notify("Failed to find Python exectuable for Poetry workspace", vim.log.levels.WARN)
      end
    end
  end,
}
