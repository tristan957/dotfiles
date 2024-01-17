---@type LazySpec[]
return {
  {
    "rcarriga/nvim-notify",
    event = "UIEnter",
    config = function()
      local notify = require("notify")

      notify.setup({
        stages = "fade",
      })

      vim.notify = notify

      -- Future: https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes
    end,
  },
  {
    "mrded/nvim-lsp-notify",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    -- event = "UIEnter",
    config = function()
      local lsp_notify = require("lsp-notify")

      -- Because we depend on nvim-notify, vim.notify is a fine default to use.
      -- nvim-notify will handle everything.
      lsp_notify.setup({
        done = ""
      })
    end
  },
}
