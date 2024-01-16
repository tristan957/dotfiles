vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end, { silent = true, desc = "Open diagnostic in floating window" })
vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Go to next diagnostic" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Go to previous diagnostic" }
)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Similar to o or O without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>", { desc = "Enter newline below cursor" })
vim.keymap.set("n", "OO", "O<Esc>", { desc = "Enter newline above cursor" })

vim.keymap.set("n", "Z", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })
vim.keymap.set("n", "<M-S-u>", "<cmd>nohl<CR>", { desc = "Turn off search highlighting" })

vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Go to previous quickfix item" })

vim.keymap.set("n", "<Esc>", function()
  local windows_to_close = vim.tbl_filter(function(w)
    if w == vim.api.nvim_get_current_win() then
      return false
    end

    local buf = vim.api.nvim_win_get_buf(w)
    if vim.tbl_contains({ "minifiles", "TelescopePrompt" }, vim.bo[buf].filetype) then
      return false
    end

    local config = vim.api.nvim_win_get_config(w)
    return config.relative ~= ""
  end, vim.api.nvim_list_wins())

  for _, w in ipairs(windows_to_close) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end, { desc = "Close irregular windows" })
