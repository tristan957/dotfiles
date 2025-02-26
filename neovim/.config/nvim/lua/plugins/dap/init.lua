---@module "lazy"

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  enabled = true,
  dependencies = {
    "mfussenegger/nluarepl",
  },
  lazy = true,
  cmd = { "DapNew", "DapToggleRepl" },
  config = function()
    local dap = require("dap")

    dap.set_log_level("INFO")

    vim.keymap.set("n", "<C-w>b", "<cmd>DapToggleRepl<cr>", { desc = "Toggle the DAP REPL" })

    dap.adapters.python = require("tristan957.dap.config.debugpy")
  end,
}
