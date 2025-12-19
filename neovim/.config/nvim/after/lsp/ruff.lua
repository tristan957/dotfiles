---@type vim.lsp.Config
return {
  before_init = function(_, config)
    -- We are already in the virtual environment, so skip the setup.
    if vim.env.VIRTUAL_ENV ~= nil then
      return
    end

    local poetry = require("tristan957.utils.poetry")

    if
      poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1
    then
      config.cmd = poetry.run_command_line({ "ruff", "server" })
    end
  end,
}
