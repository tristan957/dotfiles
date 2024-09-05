---@type LazySpec
return {
  "stevearc/oil.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  config = function()
    local oil = require("oil")

    oil.setup({
      view_options = {
        show_hidden = true,
      },
    })

    vim.keymap.set("n", "\\", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
