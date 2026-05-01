local M = {}

---@type { [number]: vim.lsp.Client }
local formatters = {}

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(ev)
    formatters[ev.buf] = nil
  end,
})

---@type { [string]: boolean | string[] }
local ls_markers = {
  biome = {
    "biome.json",
  },
  clangd = {
    ".clang-format",
  },
  gopls = true,
  lua_ls = false,
  terraformls = true,
  ts_ls = false,
  stylua = {
    ".stylua.toml",
    "stylua.toml",
  },
  tinymist = true,
  rust_analyzer = {
    ".rustfmt.toml",
    "rustfmt.toml",
  },
  zls = true,
}

---Format the buffer using the first available LSP client that supports formatting
---@param bufnr integer
M.format = function(bufnr)
  local client = vim.tbl_get(formatters, bufnr)
  if client == nil then
    local clients = vim
      .iter(vim.lsp.get_clients({ bufnr = bufnr }))
      :filter(
        ---@param c vim.lsp.Client
        function(c)
          return c:supports_method("textDocument/formatting") and ls_markers[c.name] ~= false
        end
      )
      :totable()

    if #clients == 0 then
      return
    end

    client = clients[1]
    formatters[bufnr] = client
  end

  local markers = ls_markers[client.name]
  if markers == nil then
    return
  end

  if type(markers) == "boolean" and markers then
    vim.lsp.buf.format({ bufnr = bufnr, async = false, id = client.id })
    return
  end

  ---@cast markers string[]
  if vim.fs.root(0, markers) ~= nil then
    vim.lsp.buf.format({ bufnr = bufnr, async = false, id = client.id })
  end
end

return M
