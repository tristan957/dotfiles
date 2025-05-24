---@module "lazy"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "BufNewFile", "BufReadPre" },
  ---@type TSContext.UserConfig
  opts = {
    separator = "─",
    on_attach = function(bufnr)
      -- Do not attach if there is no treesitter parser for the filetype
      local ok, _ = pcall(vim.treesitter.get_parser, bufnr)

      return ok
    end,
  },
  config = function(_, opts)
    local context = require("treesitter-context")

    context.setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      callback = function(ev)
        local ok, _ = pcall(vim.treesitter.get_parser, ev.buf)
        if not ok then
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
