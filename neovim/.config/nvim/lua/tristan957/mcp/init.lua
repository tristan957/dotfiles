local M = {}

local fs = require("tristan957.utils.fs")

local GLOBAL_PATHS = {
  vim.fs.joinpath(vim.env.HOME, ".cursor", "mcp.json"),
  vim.fs.joinpath(vim.env.HOME, ".vscode", "mcp.json"),
}

local LOCAL_PATHS = {
  vim.fs.joinpath(vim.env.PWD, ".cursor", "mcp.json"),
  vim.fs.joinpath(vim.env.PWD, ".vscode", "mcp.json"),
}

---MCP server configuration for stdio servers
---@class StdioMCPServerConfig
---@field type "stdio"
---@field command string
---@field args string[]
---@field env table<string, string>

---MCP server configuration
---@alias MCPServerConfig StdioMCPServerConfig

---VSCode (and Cursor) MCP configuration
---@class VSCodeMCPConfig
---@field mcpServers table<string, MCPServerConfig>

---Recursively replace ${env:VAR} placeholders in a value with the corresponding
---environment variable
---@param value any
---@return any
local function expand_env(value)
  if type(value) == "string" then
    return value:gsub("%$%{env:([^}]+)%}", function(var)
      return vim.env[var] or ""
    end)
  end

  if type(value) == "table" then
    local result = {}
    for k, v in pairs(value) do
      result[expand_env(k)] = expand_env(v)
    end

    return result
  end

  return value
end

---Parse an mcp.json file and expand ${env:XXX} placeholders with environment
---variable values
---@param path string Path to the mcp.json file
---@return VSCodeMCPConfig|nil config Parsed config, or nil on error
---@return string|nil err Error message if parsing failed
local function parse_vscode_mcp_config(path)
  local file = io.open(path, "r")
  if not file then
    return nil, string.format("Could not open file: %s", path)
  end

  local content = file:read("*a")
  file:close()
  if not content or content == "" then
    return nil, "File is empty"
  end

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok then
    return nil, string.format("Invalid JSON: %s", decoded)
  end

  return expand_env(decoded), --[[@as VSCodeMCPConfig]]
    nil
end

---Load MCP servers
---
---Loads servers from the following paths:
---
---Global paths (first existing):
---* ~/.cursor/mcp.json
---* ~/.vscode/mcp.json
---
---Local paths (first existing):
---* {cwd}/.cursor/mcp.json
---* {cwd}/.vscode/mcp.json
---
---Merges configs with local overriding global
---@return table<string, MCPServerConfig> servers Loaded servers
function M.load_servers()
  ---@type table<string, MCPServerConfig>
  local servers = {}

  --Paths to load
  local global_path = fs.first_existing(GLOBAL_PATHS)
  local local_path = fs.first_existing(LOCAL_PATHS)
  local paths_to_load = {}
  if global_path then
    table.insert(paths_to_load, global_path)
  end
  if local_path then
    table.insert(paths_to_load, local_path)
  end

  for _, path in ipairs(paths_to_load) do
    local config = parse_vscode_mcp_config(path)
    if config and config.mcpServers then
      for name, server in pairs(config.mcpServers) do
        if server.type == "stdio" and server.command and vim.fn.executable(server.command) == 1 then
          servers[name] = server
        end
      end
    end
  end

  return servers
end

return M
