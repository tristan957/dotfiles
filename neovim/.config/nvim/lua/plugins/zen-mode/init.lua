---@type LazySpec
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  config = function()
    vim.keymap.set("n", "ZM", vim.cmd.ZenMode, { desc = "Toggle zen mode" })
  end
}
