---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.misc",
  enabled = true,
  event = "VimEnter",
  config = function()
    local MiniMisc = require("mini.misc")

    MiniMisc.setup()
    MiniMisc.setup_restore_cursor()
  end,
}
