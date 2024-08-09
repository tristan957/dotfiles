vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype ~= "" then
      return
    end

    local ft = vim.filetype.match({ buf = ev.buf })
    if ft ~= nil then
      vim.bo[ev.buf].filetype = ft
    end
  end,
})

vim.keymap.set("n", "]b", vim.cmd.bnext, { desc = "Go to next buffer" })
vim.keymap.set("n", "[b", vim.cmd.bprevious, { desc = "Go to previous buffer" })
