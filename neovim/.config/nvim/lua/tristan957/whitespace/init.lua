-- https://superuser.com/a/607168
vim.keymap.set(
  "n",
  "[<Space>",
  ':<C-u>put =repeat(nr2char(10), v:count)<Bar>execute "\'[-1"<CR>',
  { desc = "Add newlines above cursor", silent = true }
)

vim.keymap.set(
  "n",
  "]<Space>",
  ':<C-u>put!=repeat(nr2char(10), v:count)<Bar>execute "\']+1"<CR>',
  { desc = "Add newlines beneath cursor", silent = true }
)
