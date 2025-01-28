---@module "lspconfig"

local enabled = vim.fn.filereadable("biome.json") == 1

if not enabled then
  local package_json = require("tristan957.utils.package_json")
  local devDependencies = package_json["devDependencies"]
  if devDependencies ~= nil then
    enabled = vim.tbl_get(devDependencies, "@biomejs/biome") ~= nil
  end
end

---@type lspconfig.Config
---@diagnostic disable-next-line: missing-fields
return {
  enabled = enabled,
}
