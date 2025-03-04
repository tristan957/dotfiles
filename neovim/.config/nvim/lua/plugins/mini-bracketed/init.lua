---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.bracketed",
  enabled = true,
  event = "VeryLazy",
  opts = {
    buffer = { suffix = "b", options = {} },
    comment = { suffix = "c", options = {} },
    conflict = { suffix = "x", options = {} },
    diagnostic = { suffix = "d", options = {} },
    file = { suffix = "f", options = {} },
    indent = { suffix = "i", options = {} },
    jump = { suffix = "", options = {} },
    location = { suffix = "l", options = {} },
    oldfile = { suffix = "", options = {} },
    quickfix = { suffix = "q", options = {} },
    treesitter = { suffix = "n", options = {} },
    undo = { suffix = "", options = {} },
    window = { suffix = "w", options = {} },
    yank = { suffix = "y", options = {} },
  },
}
