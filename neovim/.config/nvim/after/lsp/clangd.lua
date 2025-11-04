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
      if #opts.fargs == 0 then
        vim.ui.select(
          vim.fs.find(function(name, _)
            return name:match("compile_commands%.json")
          end, {
            limit = math.huge,
            type = "file",
          }),
          {
            prompt = "Choose a compilation database",
          },
          function(compdb, _)
            if compdb == nil then
              return
            end

            chcompdb(compdb)
          end
        )
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
