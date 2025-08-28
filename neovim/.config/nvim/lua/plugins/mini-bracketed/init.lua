---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.bracketed",
  enabled = true,
  event = "VeryLazy",
  opts = {
    buffer = { suffix = "", options = {} },
    comment = { suffix = "c", options = {} },
    conflict = { suffix = "x", options = {} },
    diagnostic = { suffix = "", options = {} },
    file = { suffix = "f", options = {} },
    indent = { suffix = "i", options = {} },
    jump = { suffix = "", options = {} },
    location = { suffix = "", options = {} },
    oldfile = { suffix = "", options = {} },
    quickfix = { suffix = "", options = {} },
    treesitter = { suffix = "n", options = {} },
    undo = { suffix = "", options = {} },
    window = { suffix = "w", options = {} },
    yank = { suffix = "y", options = {} },
  },
}
