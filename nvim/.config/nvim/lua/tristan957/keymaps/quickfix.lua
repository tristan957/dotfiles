local utils = require("tristan957.keymaps.utils")

local function toggle_qf()
  local orig = vim.fn.winnr("$")
  vim.cmd.cwindow()
  local new = vim.fn.winnr("$")

  if orig == new then
    vim.cmd.cclose()
  end
end

local function cnext_wrap()
  local total = vim.tbl_count(vim.fn.getqflist())

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
  utils.vcountify(function()
    local qflist = vim.fn.getqflist({ idx = 0 })

    if qflist.idx == 1 then
      vim.cmd.clast()
    else
      vim.cmd.cprevious()
    end
  end)
end

vim.keymap.set("n", "]q", cnext_wrap, { desc = "Go to next quickfix item" })
vim.keymap.set("n", "[q", cprevious_wrap, { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "\\q", toggle_qf, { desc = "Toggle the quickfix list" })
