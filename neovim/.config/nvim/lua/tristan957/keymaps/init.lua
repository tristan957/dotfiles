-- These don't currently work if selection includes the top or bottom lines.
-- vim.keymap.set("v", "<M-k>", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
-- vim.keymap.set("v", "<M-j>", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- This somehow doesn't work great with undo. Indent the feedkeys line in, and
-- then try to undo. Cursor goes to beginning of line.
-- local function move_horizontally(cmd)
--   return function()
--     local ref_curpos = vim.fn.getcurpos()
--     local ref_last_col = vim.fn.col("$")
--
--     vim.api.nvim_feedkeys(cmd, "xtn", false)
--
--     local col_diff = vim.fn.col("$") - ref_last_col
--     local new_col = math.max(ref_curpos[3] + col_diff, 1)
--     vim.fn.cursor({ vim.fn.line("."), new_col, ref_curpos[4], ref_curpos[5] + col_diff })
--   end
-- end
-- vim.keymap.set("v", "<M-l>", move_horizontally(">gv"), { desc = "Move selection rightward" })
-- vim.keymap.set("v", "<M-h>", move_horizontally("<gv"), { desc = "Move selection rightward" })

-- https://superuser.com/a/607168
vim.keymap.set(
  "n",
  "]<Space>",
  ':<C-u>put =repeat(nr2char(10), v:count)<Bar>execute "\'[-1"<CR>',
  { desc = "Add newlines above cursor", silent = true }
)
vim.keymap.set(
  "n",
  "]<Space>",
  ':<C-u>put!=repeat(nr2char(10), v:count)<Bar>execute "\']+1"<CR>',
  { desc = "Add newlines beneath cursor", silent = true }
)

vim.keymap.set({ "i", "n" }, "<A-U>", vim.cmd.nohlsearch, { desc = "Turn off search highlighting" })

require("tristan957.keymaps.buffers")
require("tristan957.keymaps.diagnostics")
require("tristan957.keymaps.quickfix")
