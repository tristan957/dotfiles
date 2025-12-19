---@type vim.lsp.Config
return {
  cmd = { "ty", "server" },
  before_init = function(_, config)
    local poetry = require("tristan957.utils.poetry")

    -- We are already in the virtual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    if
      poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1
    then
      -- Check if ruff is installed in the workspace
      if poetry.run({ "ty", "--version" }).code ~= 0 then
        return
      end

      config.cmd = { "poetry", "run", "--", "ty", "server" }
    end
  end,
}
