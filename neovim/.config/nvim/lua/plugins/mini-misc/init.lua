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

    local term_program = vim.env.TERM_PROGRAM
    if not vim.env.NVIM and (term_program == nil or term_program ~= "vscode") then
      MiniMisc.setup_termbg_sync()
    end
  end,
}
