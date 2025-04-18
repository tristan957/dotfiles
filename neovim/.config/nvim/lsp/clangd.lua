---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--all-scopes-completion=false",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--enable-config",
    "--pch-storage=disk",
    "--header-insertion-decorators",
  },
  on_init = function()
    vim.api.nvim_create_user_command("Chcompdb", function(opts)
      local chcompdb = require("tristan957.chcompdb").chcompdb

      if #opts.fargs == 0 then
        local fzf_lua = require("fzf-lua")

        fzf_lua.fzf_exec("find -type f -name 'compile_commands.*'", {
          prompt = "Compilation Database> ",
          actions = {
            ["default"] = function(selected)
              chcompdb(selected[1])
            end,
          },
          -- This isn't working as expected for some reason
          -- fn_transform = function(db)
          --   return fzf_lua.make_entry.file(db, { file_icons = true, color_icons = true })
          -- end,
        })
      elseif #opts.fargs == 1 then
        chcompdb(opts.fargs[1])
      else
        vim.notify("Too many arguments passed to chcompdb", vim.log.levels.ERROR)
      end
    end, {
      nargs = "?",
      complete = "file",
    })
  end,
  on_exit = function()
    vim.api.nvim_del_user_command("Chcompdb")
  end,
}
