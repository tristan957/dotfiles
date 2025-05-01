local M = {}

local function BufferName()
  return "Dashboard"
end

M.sections = {
  lualine_a = { BufferName },
}

M.filetypes = { "snacks_dashboard" }

return M
