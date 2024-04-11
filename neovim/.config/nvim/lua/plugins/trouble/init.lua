---@type LazySpec
return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local trouble = require("trouble")

    trouble.setup({
      icons = true,
      indent_lines = true,
      win_config = {
        border = "rounded",
      },
      use_diagnostic_signs = true,
    })

    vim.keymap.set("n", "\\t", vim.cmd.TroubleToggle, { silent = true })
  end,
}
