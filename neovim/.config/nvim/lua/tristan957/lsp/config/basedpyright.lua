---@module "lspconfig"

---https://docs.basedpyright.com/dev/configuration/language-server-settings/
---@type lspconfig.Config
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
  on_new_config = function(new_config, new_root_dir)
    local default_config = require("lspconfig.configs.basedpyright").default_config

    -- We are already in the virual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if
      vim.uv.fs_stat(vim.fs.joinpath(new_root_dir, "poetry.lock"))
      and vim.fn.executable("poetry") == 1
    then
      new_config.cmd = { "poetry", "run", "--", table.unpack(default_config.cmd) }
    end
  end,
}
