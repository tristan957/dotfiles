---@module "lspconfig"

---@type lspconfig.Config | {}
return {
  on_new_config = function(new_config, new_root_dir)
    local poetry = require("tristan957.utils.poetry")
    local default_config = require("lspconfig.configs.ruff").default_config

    -- We are already in the virual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if poetry.is_workspace(new_root_dir) and vim.fn.executable("poetry") == 1 then
      -- Check if ruff is installed in the workspace
      if poetry.run({ "ruff", "--version" }).code ~= 0 then
        return
      end

      new_config.cmd = { "poetry", "run", "--", "ruff", table.unpack(default_config.cmd, 2) }
    end
  end,
}
