---@module "lazy"
---@module "nvim-treesitter-textobjects"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  cond = require("tristan957.treesitter").is_cli_available() and vim.fn.has("nvim-0.11") == 1,
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",
  ---@type TSTextObjects.UserConfig
  opts = {
    select = {
      lookahead = true,
      selection_modes = {
        ["@class.outer"] = "<c-v>",
        ["@function.outer"] = "V",
        ["@parameter.outer"] = "v",
      },
      include_surrounding_whitespace = function(_)
        return false
      end,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      desc = "Attach nvim-treesitter-textobjects if and only if a parser is available",
      callback = function(ev)
        if not require("tristan957.treesitter").has_parser(vim.bo[ev.buf].filetype) then
          return
        end

        ---@param lhs string
        ---@param query_string string
        ---@param query_group string
        local add_textobject_keymap = function(lhs, query_string, query_group)
          vim.keymap.set({ "x", "o" }, lhs, function()
            require("nvim-treesitter-textobjects.select").select_textobject(
              query_string,
              query_group
            )
          end, { buffer = ev.buf })
        end

        add_textobject_keymap("ab", "@block.outer", "textobjects")
        add_textobject_keymap("ib", "@block.inner", "textobjects")
        add_textobject_keymap("ac", "@comment.outer", "textobjects")
        add_textobject_keymap("ic", "@comment.inner", "textobjects")
        add_textobject_keymap("af", "@function.outer", "textobjects")
        add_textobject_keymap("if", "@function.inner", "textobjects")
        add_textobject_keymap("af", "@class.outer", "textobjects")
        add_textobject_keymap("if", "@class.inner", "textobjects")
        add_textobject_keymap("aS", "@local.scope", "locals")
      end,
    })
  end,
}
