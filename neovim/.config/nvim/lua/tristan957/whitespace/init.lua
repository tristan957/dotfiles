local MiniTrailspace = require("mini.trailspace")

local group = vim.api.nvim_create_augroup("tristan957_whitespace", { clear = true })

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

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  group = group,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end

    -- If we ask for trailing whitespace, respect it
    if string.find(vim.bo[ev.buf].formatoptions, "w") ~= nil then
      return
    end

    MiniTrailspace.trim()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove extra trailing newlines",
  group = group,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end

    MiniTrailspace.trim_last_lines()
  end,
})
