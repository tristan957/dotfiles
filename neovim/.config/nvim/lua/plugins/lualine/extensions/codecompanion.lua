---@module "lualine"

local M = {}

local processing = false
local spinner_index = 1

local spinner_symbols = {
  "⠋",
  "⠙",
  "⠹",
  "⠸",
  "⠼",
  "⠴",
  "⠦",
  "⠧",
  "⠇",
  "⠏",
}

local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = "CodeCompanionRequest*",
  group = group,
  callback = function(ev)
    if ev.match == "CodeCompanionRequestStarted" then
      processing = true
    elseif ev.match == "CodeCompanionRequestFinished" then
      processing = false
    end
  end,
})

function CodeCompanionProgress()
  if processing then
    spinner_index = (spinner_index % #spinner_symbols) + 1
    return spinner_symbols[spinner_index] .. " "
  end

  return " "
end

function BufferName()
  return "CodeCompanion"
end

M.sections = {
  lualine_a = { "mode" },
  lualine_c = { BufferName },
  lualine_x = {
    CodeCompanionProgress,
  },
  lualine_y = { "progress" },
  lualine_z = { "location" },
}

M.filetypes = { "codecompanion" }

return M
