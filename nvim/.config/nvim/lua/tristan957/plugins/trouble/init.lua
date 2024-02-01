---@type LazySpec
return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    local trouble = require("trouble")

    trouble.setup({
      icons = true,
      indent_lines = true, -- add an indent guide below the fold icons
      win_config = {
        border = "rounded",
      },
      use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    })

    vim.keymap.set("n", "\\t", vim.cmd.TroubleToggle, { silent = true })
  end,
}
