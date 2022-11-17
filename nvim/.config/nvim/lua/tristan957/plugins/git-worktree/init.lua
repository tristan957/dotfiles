require("telescope").load_extension("git_worktree")

vim.api.nvim_set_keymap(
  "n",
  "<leader>gw",
  "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>gwc",
  "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
  { noremap = true, silent = true }
)
