vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { silent = true, desc = "Open diagnostic in floating window" })
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Go to next diagnostic" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Go to previous diagnostic" }
)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

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

-- Similar to o or O without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>", { desc = "Enter newline below cursor" })
vim.keymap.set("n", "OO", "O<Esc>", { desc = "Enter newline above cursor" })

vim.keymap.set("n", "Z", vim.cmd.ZenMode, { desc = "Toggle zen mode" })
vim.keymap.set("n", "<M-S-u>", vim.cmd.nohlsearch, { desc = "Turn off search highlighting" })

local function toggle_qf()
  local orig = vim.fn.winnr("$")
  vim.cmd.cwindow()
  local new = vim.fn.winnr("$")

  if orig == new then
    vim.cmd.cclose()
  end
end
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Go to next quickfix item" })
vim.keymap.set("n", "[q", vim.cmd.cprevious, { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "\\q", toggle_qf, { desc = "Toggle the quickfix list" })

vim.keymap.set("n", "<Esc>", function()
  local windows_to_close = vim.tbl_filter(function(w)
    if w == vim.api.nvim_get_current_win() then
      return false
    end

    local buf = vim.api.nvim_win_get_buf(w)
    if vim.tbl_contains({ "minifiles", "TelescopePrompt" }, vim.bo[buf].filetype) then
      return false
    end

    local config = vim.api.nvim_win_get_config(w)
    return config.relative ~= ""
  end, vim.api.nvim_list_wins())

  for _, w in ipairs(windows_to_close) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end, { desc = "Close irregular windows" })
