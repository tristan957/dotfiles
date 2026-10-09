---@alias TrailerPrefix
---| '"Reviewed-by"'
---| '"Signed-off-by"'

---@param prefix TrailerPrefix
local function insert(prefix)
  local cmd = vim
    .system({
      "git",
      "user",
    })
    :wait()

  if cmd.code ~= 0 then
    vim.notify('"git user" command failed')
    return
  end

  vim.api.nvim_put({ string.format("%s: %s", prefix, cmd.stdout) }, "", false, true)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "gitcommit",
    "mail",
  },
  callback = function(ev)
    vim.api.nvim_buf_create_user_command(ev.buf, "Trailer", function(args)
      if #args.fargs == 0 then
        vim.ui.select(
          {
            "Reviewed-by",
            "Signed-off-by",
          } --[[@as TrailerPrefix[] ]],
          {
            prompt = "Trailer to insert",
          },
          ---@param prefix TrailerPrefix?
          function(prefix)
            if prefix == nil then
              return
            end

            insert(prefix)
          end
        )
      end
    end, {
      nargs = "?",
      complete = function(_, _, _)
        return {
          "Reviewed-by",
          "Signed-off-by",
        }
      end,
    })
  end,
})
