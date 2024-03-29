---@type LazySpec
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
      on_attach = function(bufnr)
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end

          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return "<Ignore>"
        end, opts)

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end

          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return "<Ignore>"
        end, opts)

        vim.keymap.set("n", "\\h", gitsigns.preview_hunk_inline, opts)
      end,
    })
  end,
}
