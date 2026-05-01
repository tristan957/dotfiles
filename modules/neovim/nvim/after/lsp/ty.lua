--https://docs.astral.sh/ty/reference/configuration/

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, _)
    local cmd = { "ty", "server" }

    --We are already in the virtual environment, so skip the setup
    if vim.env.VIRTUAL_ENV == nil then
      local poetry = require("tristan957.utils.poetry")

      if
        poetry.is_workspace(vim.uv.cwd() --[[@as string]]) and vim.fn.executable("poetry") == 1
      then
        cmd = poetry.run_command_line({ "ty", "server" })
      end
    end

    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
}
