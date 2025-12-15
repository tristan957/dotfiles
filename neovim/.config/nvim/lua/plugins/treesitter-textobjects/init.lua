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
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    vim.g.no_plugin_maps = true
  end,
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      desc = "Attach nvim-treesitter-textobjects if and only if a parser is available",
      callback = function(ev)
        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

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
        add_textobject_keymap("am", "@function.outer", "textobjects")
        add_textobject_keymap("im", "@function.inner", "textobjects")
        add_textobject_keymap("ak", "@class.outer", "textobjects")
        add_textobject_keymap("ik", "@class.inner", "textobjects")
        add_textobject_keymap("aS", "@local.scope", "locals")

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- vim way: ; goes to the direction you were moving.
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Repeatable f, F, t, T expressions
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
      end,
    })
  end,
}
