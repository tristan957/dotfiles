local function chcompdb(opts)
  vim.system({ "chcompdb", "--quiet", opts.fargs[1] }, {}, function(o)
    if o.code ~= 0 then
      vim.notify(o.stderr, vim.log.levels.ERROR)
      return
    end

    vim.notify("Changed the active compilation database to " .. opts.fargs[1], vim.log.levels.INFO)
  end)
end

vim.api.nvim_create_user_command("Chcompdb", chcompdb, {
  nargs = 1,
  complete = "file",
})
