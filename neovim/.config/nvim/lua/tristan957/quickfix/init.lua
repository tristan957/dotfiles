local utils = require("tristan957.utils")

local group = vim.api.nvim_create_augroup("tristan957/quickfix", { clear = true })

local function toggle_qflist()
  local orig = vim.fn.winnr("$")
  vim.cmd.cwindow()
  local new = vim.fn.winnr("$")

  if orig == new then
    vim.cmd.cclose()
  end
end

local function cnext_wrap()
  local total = vim.tbl_count(vim.fn.getqflist())

  if total == 0 then
    return
  end

  utils.vcountify(function()
    local qflist = vim.fn.getqflist({ idx = 0 })

    if qflist.idx == total then
      vim.cmd.cfirst()
    else
      vim.cmd.cnext()
    end
  end)
end

local function cprevious_wrap()
  local total = vim.tbl_count(vim.fn.getqflist())

  if total == 0 then
    return
  end

  utils.vcountify(function()
    local qflist = vim.fn.getqflist({ idx = 0 })

    if qflist.idx == 1 then
      vim.cmd.clast()
    else
      vim.cmd.cprevious()
    end
  end)
end

vim.keymap.set("n", "[Q", vim.cmd.colder, { desc = "Go to older quickfix list" })
vim.keymap.set("n", "]Q", vim.cmd.cnewer, { desc = "Go to newer quickfix list" })
vim.keymap.set("n", "]q", cnext_wrap, { desc = "Go to next quickfix item" })
vim.keymap.set("n", "[q", cprevious_wrap, { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "\\q", toggle_qflist, { desc = "Toggle the quickfix list" })
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

local function lnext_wrap()
  local window = vim.api.nvim_get_current_win()
  local total = vim.tbl_count(vim.fn.getloclist(window))

  if total == 0 then
    return
  end

  utils.vcountify(function()
    local loclist = vim.fn.getloclist(window, { idx = 0 })

    if loclist.idx == total then
      vim.cmd.lfirst()
    else
      vim.cmd.lnext()
    end
  end)
end

local function lprevious_wrap()
  local window = vim.api.nvim_get_current_win()
  local total = vim.tbl_count(vim.fn.getloclist(window))

  if total == 0 then
    return
  end

  utils.vcountify(function()
    local loclist = vim.fn.getloclist(window, { idx = 0 })

    if loclist.idx == 1 then
      vim.cmd.llast()
    else
      vim.cmd.lprevious()
    end
  end)
end

vim.keymap.set("n", "[L", vim.cmd.lolder, { desc = "Go to older location list" })
vim.keymap.set("n", "]L", vim.cmd.lnewer, { desc = "Go to newer location list" })
vim.keymap.set("n", "]l", lnext_wrap, { desc = "Go to next location list item" })
vim.keymap.set("n", "[l", lprevious_wrap, { desc = "Go to previous location list item" })
vim.keymap.set("n", "\\l", toggle_loclist, { desc = "Toggle the location list" })
vim.keymap.set("n", "|l", function()
  local window = vim.api.nvim_get_current_win()

  vim.fn.setloclist(window, {}, "r")
  vim.cmd.lclose()
end, { desc = "Clear the location list" })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open quickfix window",
  group = group,
  pattern = "[^l]*",
  nested = true,
  callback = "cwindow",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Automatically open loclist window",
  group = group,
  pattern = "l*",
  nested = true,
  callback = "lwindow",
})
