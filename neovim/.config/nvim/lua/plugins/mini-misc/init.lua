---@module "lazy"

---@type LazySpec
return {
  "echasnovski/mini.misc",
  event = "VimEnter",
  config = function()
    local MiniMisc = require("mini.misc")

    MiniMisc.setup()
    MiniMisc.setup_restore_cursor()

    local term_program = vim.env.TERM_PROGRAM
    if term_program ~= nil and (term_program ~= "vscode") then
      MiniMisc.setup_termbg_sync()
    end
  end,
}
