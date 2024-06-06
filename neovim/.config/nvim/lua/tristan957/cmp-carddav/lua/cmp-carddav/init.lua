local M = {}

---@class cmp_carddav.Options
---@field binary_path string?
---@field section string?

---@type cmp_carddav.Options
local global_opts = {
  binary_path = "carddav-query",
}

---Setup the plugin
---@param opts cmp_carddav.Options
M.setup = function(opts)
  global_opts = vim.tbl_deep_extend("force", global_opts, opts)
end

return M
