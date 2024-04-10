local group = vim.api.nvim_create_augroup("tristan957/linenumbers", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  desc = "Turn on relative number when focused",
  group = group,
  callback = function()
    if not vim.wo.number then
      return
    end

    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  desc = "Turn off relative number when focus lost",
  group = group,
  callback = function()
    if not vim.wo.number then
      return
    end

    vim.wo.relativenumber = false
  end,
})
