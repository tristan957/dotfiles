--- Run chcompdb(1) to change the compilation database
---@param compdb string
_G.chcompdb = function(compdb)
  vim.system({ "chcompdb", "--quiet", compdb }, {}, function(o)
    if o.code ~= 0 then
      vim.notify(o.stderr, vim.log.levels.ERROR)
      return
    end

    vim.notify("Changed the active compilation database to " .. compdb, vim.log.levels.INFO)
  end)
end
