---Run chcompdb(1) to change the compilation database
---@param compdb string
local function chcompdb(compdb)
  vim.system({ "chcompdb", "--quiet", compdb }, {}, function(o)
    vim.schedule(function()
      if o.code ~= 0 then
        vim.notify(o.stderr, vim.log.levels.ERROR)
        return
      end

      vim.notify("Changed the active compilation database to " .. compdb, vim.log.levels.INFO)
    end)
  end)
end

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
