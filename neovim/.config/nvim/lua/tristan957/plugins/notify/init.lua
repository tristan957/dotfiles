---@type LazySpec
return {
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
}
