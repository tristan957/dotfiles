---@type LazySpec
return {
  "echasnovski/mini.bracketed",
  event = "VeryLazy",
  config = function()
    local MiniBracketed = require("mini.bracketed")

    MiniBracketed.setup({
      buffer = { suffix = "", options = {} },
      comment = { suffix = "c", options = {} },
      conflict = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file = { suffix = "", options = {} },
      indent = { suffix = "i", options = {} },
      jump = { suffix = "", options = {} },
      location = { suffix = "l", options = {} },
      oldfile = { suffix = "", options = {} },
      quickfix = { suffix = "q", options = {} },
      treesitter = { suffix = "n", options = {} },
      undo = { suffix = "", options = {} },
      window = { suffix = "w", options = {} },
      yank = { suffix = "y", options = {} },
    })
  end,
}
