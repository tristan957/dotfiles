---@module "lazy"

---@type LazySpec
return {
  "barrettruth/diffs.nvim",
  init = function()
    vim.g.diffs = {
      extra_filetypes = { "diff" },
      integrations = {
        gitsigns = false,
        fugitive = true,
        neogit = false,
      },
    }
  end,
  config = function()
    vim.keymap.set("n", "<leader>co", "<Plug>(diffs-conflict-ours)")
    vim.keymap.set("n", "<leader>ct", "<Plug>(diffs-conflict-theirs)")
    vim.keymap.set("n", "<leader>cb", "<Plug>(diffs-conflict-both)")
    vim.keymap.set("n", "<leader>c0", "<Plug>(diffs-conflict-none)")
    -- I use the keymaps from mini.bracketed
    -- vim.keymap.set("n", "]x", "<Plug>(diffs-conflict-next)")
    -- vim.keymap.set("n", "[x", "<Plug>(diffs-conflict-prev)")
  end,
}
