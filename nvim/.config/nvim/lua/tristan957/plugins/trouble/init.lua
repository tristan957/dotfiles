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
      indent_lines = false, -- add an indent guide below the fold icons
      use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    })

    vim.keymap.set("n", "<leader>dt", "<cmd>TroubleToggle<CR>", { silent = true })
  end,
}
