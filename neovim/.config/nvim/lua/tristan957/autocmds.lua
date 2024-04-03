local MiniTrailspace = require("mini.trailspace")

local group = vim.api.nvim_create_augroup("tristan957", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  desc = "Turn on relative number when focused",
  group = group,
  callback = function()
    if not vim.wo.number then
      return
    end

    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  desc = "Turn off relative number when focus lost",
  group = group,
  callback = function()
    if not vim.wo.number then
      return
    end

    vim.wo.relativenumber = false
  end,
})

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

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = group,
  callback = function()
    vim.highlight.on_yank()
  end,
})
