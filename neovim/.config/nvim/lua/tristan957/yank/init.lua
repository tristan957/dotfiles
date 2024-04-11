local group = vim.api.nvim_create_augroup("tristan957/yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})
