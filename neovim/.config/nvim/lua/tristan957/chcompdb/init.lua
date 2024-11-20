---Run chcompdb to change the compilation database
---@param compdb string
local function chcompdb(compdb)
  vim.system({ "chcompdb", "--quiet", compdb }, {}, function(o)
    if o.code ~= 0 then
      vim.notify(o.stderr, vim.log.levels.ERROR)
      return
    end

    vim.notify("Changed the active compilation database to " .. compdb, vim.log.levels.INFO)
  end)
end

vim.api.nvim_create_user_command("Chcompdb", function(opts)
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
