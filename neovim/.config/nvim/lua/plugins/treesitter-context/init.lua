---@module "lazy"
---@module "treesitter-context"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufNewFile", "BufReadPre" },
  ---@type TSContext.UserConfig
  opts = {
    separator = "─",
    on_attach = function(bufnr)
      -- Do not attach if there is no treesitter parser for the filetype
      return require("tristan957.treesitter").has_parser(vim.bo[bufnr].filetype)
    end,
  },
  config = function(_, opts)
    local context = require("treesitter-context")

    context.setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      desc = "Add buffer local keymaps for interacting with nvim-treesitter-context",
      callback = function(ev)
        if not require("tristan957.treesitter").has_parser(vim.bo[ev.buf].filetype) then
          return
        end

        vim.keymap.set("n", "<C-w>C", context.toggle, { buffer = ev.buf, desc = "Toggle context" })
        vim.keymap.set("n", "[C", function()
          context.go_to_context(vim.v.count1)
        end, { buffer = ev.buf, silent = true, desc = "Jump to context" })
      end,
    })
  end,
}
