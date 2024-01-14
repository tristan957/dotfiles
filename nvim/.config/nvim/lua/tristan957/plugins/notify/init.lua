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
  end,
}
