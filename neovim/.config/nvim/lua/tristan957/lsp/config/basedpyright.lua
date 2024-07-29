local capabilities = require("tristan957.lsp").capabilities

-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
  capabilities = capabilities,
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
  ---@param client vim.lsp.Client
  on_init = function(client)
    local path = client.workspace_folders[1].name

    if vim.uv.fs_stat((vim.fs.joinpath(path, "poetry.lock"))) and vim.fn.executable("poetry") then
      client.config.settings.basedpyright =
      vim.tbl_deep_extend("force", client.config.settings.basedpyright, {
        venvPath = vim.fn.system("poetry env info --path"),
      })
    end
  end,
}
