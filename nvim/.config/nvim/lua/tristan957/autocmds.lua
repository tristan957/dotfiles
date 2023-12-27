-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Remove extra trailing newlines
local empty_line = vim.regex("^$")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
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
