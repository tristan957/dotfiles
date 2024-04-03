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
    if not vim.bo[ev.buf].modifiable then
      return
    end

    -- If we ask for trailing whitespace, respect it
    if string.find(vim.bo[ev.buf].formatoptions, "w") ~= nil then
      return
    end

    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove extra trailing newlines",
  group = group,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end

    local n_lines = vim.api.nvim_buf_line_count(ev.buf)
    local last_nonblank = vim.fn.prevnonblank(n_lines)

    if last_nonblank < n_lines then
      vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})
