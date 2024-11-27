---@module "lazy"

vim.api.nvim_create_user_command("Fzf", "FzfLua", { desc = "Alias for FzfLua" })

---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "echasnovski/mini.icons",
  },
  cmd = { "Fzf", "FzfLua" },
  keys = {
    {
      "<Leader><Leader>",
      function()
        require("fzf-lua").files()
      end,
      mode = "n",
      desc = "Open file picker",
    },
    {
      "<Leader>b",
      function()
        require("fzf-lua").buffers()
      end,
      mode = "n",
      desc = "Open buffer picker",
    },
    {
      "<Leader>F",
      function()
        require("fzf-lua").live_grep_native()
      end,
      mode = "n",
      desc = "Find in project",
    },
    {
      "<Leader>h",
      function()
        require("fzf-lua").helptags()
      end,
      mode = "n",
      desc = "Find help tag",
    },
    {
      "<Leader>k",
      function()
        require("fzf-lua").keymaps()
      end,
      mode = "n",
      desc = "Search keymaps",
    },
    {
      "<Leader>m",
      function()
        require("fzf-lua").marks()
      end,
      mode = "n",
      desc = "Search marks",
    },
    {
      "<Leader>r",
      function()
        require("fzf-lua").registers()
      end,
      mode = "n",
      desc = "Search registers",
    },
    {
      "<Leader>R",
      function()
        require("fzf-lua").resume()
      end,
      mode = "n",
      desc = "Resume last picker",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local utils = require("fzf-lua.utils")

    local toggle_fixed_strings = {
      fn = function(_, opts)
        actions.toggle_flag(_, vim.tbl_deep_extend("force", opts, { toggle_flag = "--fixed-strings" }))
      end,
      desc = "toggle-fixed-strings",
      header = function(o)
        local flag = "--fixed-strings"
        vim.print(o.cmd)
        if o.cmd and o.cmd:match(utils.lua_regex_escape(flag)) then
          return "Disable fixed strings"
        else
          return "Enable fixed strings"
        end
      end,
    }

    fzf.setup({
      grep = {
        actions = {
          ["ctrl-r"] = { actions.toggle_ignore },
          ["ctrl-q"] = {
            fn = actions.file_edit_or_qf, prefix = "select-all+",
          },
          ["ctrl-e"] = toggle_fixed_strings,
        },
      },
    })

    fzf.register_ui_select()
  end,
}
