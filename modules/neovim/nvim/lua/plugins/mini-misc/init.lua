---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.misc",
  opts = {
    center = true,
  },
  config = function()
    local MiniMisc = require("mini.misc")

    MiniMisc.setup()

    MiniMisc.setup_restore_cursor()
  end,
}
