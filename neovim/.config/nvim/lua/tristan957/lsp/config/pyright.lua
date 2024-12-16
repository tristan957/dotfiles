---@module "lspconfig"

---https://github.com/microsoft/pyright/blob/main/docs/settings.md
---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
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
  on_new_config = function(new_config, new_root_dir)
    local poetry = require("tristan957.utils.poetry")
    local default_config = require("lspconfig.configs.basedpyright").default_config

    -- We are already in the virual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if poetry.is_workspace(new_root_dir) and vim.fn.executable("poetry") == 1 then
      new_config.cmd = { "poetry", "run", "--", table.unpack(default_config.cmd) }
    end
  end,
}
