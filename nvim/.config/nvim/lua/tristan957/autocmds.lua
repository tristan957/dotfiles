local group = vim.api.nvim_create_augroup("tristan957", { clear = true })

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

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  group = group,
  callback = function(ev)
    -- If we ask for trailing whitespace, respect it
    if string.find(vim.bo[ev.buf].formatoptions, "w") ~= nil then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

local empty_line = vim.regex("^$")
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove extra trailing newlines",
  group = group,
  callback = function(ev)
    local view = vim.fn.winsaveview()

    local line = vim.fn.line("$") - 1
    while empty_line:match_line(ev.buf, line) ~= nil do
      vim.cmd("$d")
      line = line - 1
    end

    vim.fn.winrestview(view)
  end,
})
