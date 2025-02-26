---@module "lazy"

---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  enabled = false,
  dependencies = {
    "echasnovski/mini.icons",
    "folke/trouble.nvim",
  },
  lazy = true,
  cmd = { "Fzf", "FzfLua" },
  init = function()
    vim.api.nvim_create_user_command("Fzf", "FzfLua", { desc = "Alias for FzfLua" })

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("fzf-lua").register_ui_select()

      vim.ui.select(...)
    end
  end,
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local fd = require("tristan957.utils.fd")
    local rg = require("tristan957.utils.rg")
    local trouble = require("trouble.sources.fzf")

    fzf.setup({
      "default-title",
      actions = {
        files = {
          true,
          ["ctrl-t"] = trouble.actions.open,
        },
      },
      winopts = {
        preview = {
          horizontal = "right:50%",
        },
      },
      files = {
        cwd_prompt = false,
        -- Need to remove the command from the arguments
        rg_opts = table.concat(vim.list_slice(rg.project_files(true), 2), " "),
        fd_opts = table.concat(vim.list_slice(fd.project_files(true), 2), " "),
      },
      grep = {
        rg_opts = table.concat(vim.list_slice(rg.grep(true), 2), " "),
        actions = {
          ["ctrl-q"] = {
            fn = actions.file_edit_or_qf,
            prefix = "select-all+",
          },
        },
      },
    })

    fzf.register_ui_select()
  end,
}
