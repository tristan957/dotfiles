---@module "lazy"

vim.api.nvim_create_user_command("Fzf", "FzfLua", { desc = "Alias for FzfLua" })

---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "echasnovski/mini.icons",
  },
  cmd = { "Fzf", "FzfLua" },
  config = function()
    local fzf = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local fd = require("tristan957.utils.fd")
    local rg = require("tristan957.utils.rg")

    fzf.setup({
      "default-title",
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
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
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
