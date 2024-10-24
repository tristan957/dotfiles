local capabilities = require("tristan957.lsp").capabilities

-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
  autostart = false,
  capabilities = capabilities,
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
  ---@param new_config vim.lsp.ClientConfig
  ---@param new_root_dir string
  on_new_config = function(new_config, new_root_dir)
    local default_config = require("lspconfig.configs.basedpyright").default_config

    -- We are already in the virual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if
      vim.fn.filereadable(vim.fs.joinpath(new_root_dir, "poetry.lock")) == 1
      and vim.fn.executable("poetry") == 1
    then
      new_config.cmd = { "poetry", "run", "--", table.unpack(default_config.cmd) }
    end
  end,
}
