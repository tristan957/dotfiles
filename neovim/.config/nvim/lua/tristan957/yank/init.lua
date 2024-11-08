vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "yY", "<CMD>%yank", { desc = "Yank the whole file" })
