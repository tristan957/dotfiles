---@module "dap"
---@module "lazy"

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nluarepl",
  },
  lazy = true,
  cmd = { "DapNew", "DapToggleRepl" },
  config = function()
    local dap = require("dap")

    dap.set_log_level("INFO")

    vim.keymap.set("n", "<C-w>b", "<cmd>DapToggleRepl<cr>", { desc = "Toggle the DAP REPL" })
    vim.keymap.set("n", "<Leader>dc", "<cmd>DapContinue<cr>", { desc = "Continue the DAP session" })
    vim.keymap.set(
      "n",
      "<Leader>db",
      "<cmd>DapToggleBreakpoint<cr>",
      { desc = "Continue the DAP session" }
    )
    vim.keymap.set(
      "n",
      "<Leader>dd",
      "<cmd>DapDisconnect<cr>",
      { desc = "Continue the DAP session" }
    )
    vim.keymap.set("n", "<Leader>dp", "<cmd>DapPause<cr>", { desc = "Continue the DAP session" })
    vim.keymap.set("n", "<Leader>di", "<cmd>DapStepInto<cr>", { desc = "Continue the DAP session" })
    vim.keymap.set("n", "<Leader>do", "<cmd>DapStepOut<cr>", { desc = "Continue the DAP session" })
    vim.keymap.set("n", "<Leader>dn", "<cmd>DapStepOver<cr>", { desc = "Continue the DAP session" })

    if vim.fn.has("macunix") == 1 then
      dap.configurations.c = require("plugins.dap.config.lldb")
      dap.configurations.rust = require("plugins.dap.config.rust-lldb")
    else
      dap.configurations.c = require("plugins.dap.config.gdb")
      dap.configurations.rust = require("plugins.dap.config.rust-gdb")
    end

    dap.adapters.gdb = require("plugins.dap.adapters.gdb")
    dap.adapters.lldb = require("plugins.dap.adapters.lldb")
    dap.adapters["rust-gdb"] = require("plugins.dap.adapters.rust-gdb")
    dap.adapters.python = require("plugins.dap.adapters.debugpy")

    dap.configurations.cpp = dap.configurations.c
  end,
}
