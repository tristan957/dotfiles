---@module "lazy"

---@type LazySpec
return {
  "https://forge.barrettruth.com/barrettruth/diffs.nvim",
  config = function()
    vim.keymap.set("n", "<leader>co", "<Plug>(diffs-conflict-ours)")
    vim.keymap.set("n", "<leader>ct", "<Plug>(diffs-conflict-theirs)")
    vim.keymap.set("n", "<leader>cb", "<Plug>(diffs-conflict-both)")
    vim.keymap.set("n", "<leader>c0", "<Plug>(diffs-conflict-none)")
    -- I use the keymaps from mini.bracketed
    -- vim.keymap.set("n", "]x", "<Plug>(diffs-conflict-next)")
    -- vim.keymap.set("n", "[x", "<Plug>(diffs-conflict-prev)")

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("tristan957_diffs", { clear = true }),
      pattern = { "diff" },
      callback = function(event)
        require("diffs").attach(event.buf)
      end,
    })
  end,
}
