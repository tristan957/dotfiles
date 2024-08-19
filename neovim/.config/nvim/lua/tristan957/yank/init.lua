local group = vim.api.nvim_create_augroup("tristan957_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "YY", "<CMD>%yank", { desc = "Yank the whole file" })
