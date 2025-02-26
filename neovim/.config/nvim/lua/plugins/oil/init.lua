---@module "lazy"

---@type LazySpec
return {
  "stevearc/oil.nvim",
  enabled = true,
  event = "VimEnter",
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  cmd = { "Oil" },
  keys = {
    { "\\\\", "<CMD>Oil<CR>", "n", desc = "Open parent directory" },
    {
      "\\|",
      function()
        local oil = require("oil")

        oil.open(vim.env.PWD)
      end,
      "n",
      desc = "Open current working directory",
    },
  },
}
