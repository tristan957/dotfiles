local function toggle_qflist()
  local orig = vim.fn.winnr("$")
  vim.cmd.cwindow()
  local new = vim.fn.winnr("$")

  if orig == new then
    vim.cmd.cclose()
  end
end

vim.keymap.set("n", "<C-W>y", toggle_qflist, { desc = "Toggle the quickfix list" })
vim.keymap.set("n", "|q", function()
  vim.fn.setqflist({}, "r")
  vim.cmd.cclose()
end, { desc = "Clear the quickfix list" })

local function toggle_loclist()
  local window = vim.api.nvim_get_current_win()

  if vim.tbl_count(vim.fn.getloclist(window)) == 0 then
    return
  end

  local orig = vim.fn.winnr("$")
  vim.cmd.lwindow()
  local new = vim.fn.winnr("$")

  if orig == new then
    vim.cmd.lclose()
  end
end

vim.keymap.set("n", "<C-W>Y", toggle_loclist, { desc = "Toggle the location list" })
vim.keymap.set("n", "|l", function()
  local window = vim.api.nvim_get_current_win()

  vim.fn.setloclist(window, {}, "r")
  vim.cmd.lclose()
end, { desc = "Clear the location list" })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open quickfix window",
  pattern = "[^l]*",
  nested = true,
  command = "cwindow",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open loclist window",
  pattern = "l*",
  nested = true,
  command = "lwindow",
})
