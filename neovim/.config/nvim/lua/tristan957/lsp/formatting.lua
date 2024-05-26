local Path = require("plenary.path")

local M = {}

---@type { [string]: string[] }
local markers = {
  clangd = {
    ".clang-format",
  },
  ["rust_analyzer"] = {
    ".rustfmt.toml",
    "rustfmt.toml",
  }
}

---@param client vim.lsp.Client
---@param bufnr number
---@param force boolean If marker is not found,
---@param opts table
M.format = function(client, bufnr, force, opts)
  if markers[client.name] == nil then
    return
  end

  local cwd = vim.loop.cwd()
  if cwd == nil then
    return
  end

  local parents = Path:new(vim.fn.bufname(bufnr)):parents()

  -- Try and find a marker between our parents and the CWD
  local found = false
  if not force then
    for _, c in ipairs(parents) do
      local p = Path:new(c)

      for _, m in ipairs(markers[client.name]) do
        if p:joinpath(m):exists() then
          found = true
          break
        end
      end

      -- Don't try to read higher than the CWD
      if c == cwd then
        break
      end
    end
  end

  if force or found then
    if type(client) == "string" then
      opts["name"] = client
    else
      opts["id"] = client.id
    end

    vim.lsp.buf.format({
      bufnr = bufnr,
      unpack(opts),
    })
  end
end

return M
