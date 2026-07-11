---@module "lazy"

---@type LazySpec
return {
  "nvim-mini/mini.misc",
  config = function()
    local MiniMisc = require("mini.misc")

    MiniMisc.setup()

    MiniMisc.setup_restore_cursor({
      center = true,
    })
  end,
}
