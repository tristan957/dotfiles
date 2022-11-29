require("trouble").setup({
  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "E",
    other = "O",
    warning = "W",
    hint = "H",
    information = "I",
  },
  use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>dt",
  "<cmd>:TroubleToggle<cr>",
  { noremap = true, silent = true }
)