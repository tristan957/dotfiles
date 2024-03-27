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

---@param client lsp.Client | string
---@param bufnr number
---@param opts table
M.format = function(client, bufnr, opts)
  if markers[client.name] == nil then
    return
  end

  local cwd = vim.uv.cwd()
  if cwd == nil then
    return
  end

  local parents = Path:new(vim.fn.bufname(bufnr)):parents()

  for _, c in ipairs(parents) do
    local p = Path:new(c)

    for _, m in ipairs(markers[client.name]) do
      if p:joinpath(m):exists() then
        if type(client) == "string" then
          opts["name"] = client
        else
          opts["id"] = client.id
        end

        vim.lsp.buf.format({
          bufnr = bufnr,
          unpack(opts),
        })

        return
      end
    end

    if c == cwd then
      break
    end
  end
end

return M
