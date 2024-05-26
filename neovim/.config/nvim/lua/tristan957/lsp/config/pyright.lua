local utils = require("tristan957.lsp.utils")
local Path = require("plenary.path")

return {
  cmd = { "pyright-langserver", "--stdio" },
  root_dir = utils.root_dir({
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "Pipfile",
    "pyrightconfig.json",
  }),
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
  ---@param client vim.lsp.Client
  on_init = function(client)
    local path = Path:new(client.workspace_folders[1].name)

    if path:joinpath("poetry.lock"):exists() and vim.fn.executable("poetry") then
      client.config.settings.python = vim.tbl_deep_extend("force", client.config.settings.python, {
        venvPath = vim.fn.system("poetry env info --path"),
      })
    end
  end,
}
