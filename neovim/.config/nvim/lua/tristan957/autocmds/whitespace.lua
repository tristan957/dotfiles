local MiniTrailspace = require("mini.trailspace")

local group = vim.api.nvim_create_augroup("tristan957/whitespace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace",
  group = group,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end

    -- If we ask for trailing whitespace, respect it
    if string.find(vim.bo[ev.buf].formatoptions, "w") ~= nil then
      return
    end

    MiniTrailspace.trim()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove extra trailing newlines",
  group = group,
  callback = function(ev)
    if not vim.bo[ev.buf].modifiable then
      return
    end

    MiniTrailspace.trim_last_lines()
  end,
})
