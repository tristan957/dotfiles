---@class PackageJson
---@field name? string
---@field version? string
---@field private? boolean
---@field scripts? { [string]: string }
---@field dependencies? { [string]: string }
---@field devDependencies? { [string]: string }

local f, err = io.open("package.json")
if err ~= nil then
  return {}
end

f = assert(f)

local data = f:read("*a")
f:close()

return vim.json.decode(data) --[[@as PackageJson]]
