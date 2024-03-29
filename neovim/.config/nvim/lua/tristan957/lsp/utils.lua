local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local common_markers = {
  ".git",
}

---Return a root directory
---@param specific_markers string[]?
M.root_dir = function(specific_markers)
  local markers
  if specific_markers == nil then
    markers = common_markers
  else
    markers = { unpack(common_markers), unpack(specific_markers) }
  end

  return vim.fs.dirname(vim.fs.find(markers, { upward = true })[1])
end

local servers = {
  awk = { "awk-language-server" },
  c = { "clangd" },
  cmake = { "cmake-language-server" },
  cpp = { "clangd" },
  css = { "vscode-css-languageserver" },
  cuda = { "clangd" },
  go = { "gopls" },
  gomod = { "gopls" },
  gowork = { "gopls" },
  gotmpl = { "gopls" },
  html = { "vscode-html-languageserver" },
  javascript = { "deno", "typescript-language-server" },
  ["javascript.jsx"] = { "deno", "typescript-language-server" },
  javascriptreact = { "deno", "typescript-language-server" },
  json = { "vscode-json-languageserver" },
  jsonc = { "vscode-json-languageserver" },
  less = { "vscode-css-languageserver" },
  lua = { "lua-language-server" },
  markdown = { "marksman" },
  ["markdown.mdx"] = { "marksman" },
  meson = { "mesonlsp" },
  objc = { "clangd" },
  objcpp = { "clangd" },
  proto = { "clangd" },
  python = { "pyright", "ruff-lsp" },
  rust = { "rust-analyzer" },
  scss = { "vscode-css-languageserver" },
  sh = { "bash-language-server" },
  svg = { "lemminx" },
  templ = { "vscode-html-languageserver" },
  terraform = { "terraform-ls" },
  ["terraform-vars"] = { "terraform-ls" },
  toml = { "taplo" },
  typescript = { "deno", "typescript-language-server" },
  ["typescript.tsx"] = { "deno", "typescript-language-server" },
  typescriptreact = { "deno", "typescript-language-server" },
  typst = { "typst-lsp" },
  vim = { "vim-language-server" },
  xml = { "lemminx" },
  xsd = { "lemminx" },
  xsl = { "lemminx" },
  xslt = { "lemminx" },
  yaml = { "yaml-language-server" },
  ["yaml.docker-compose"] = { "yaml-language-server" },
  zig = { "zls" },
  zir = { "zls" },
}

---Get a list of servers that should be started with this filetype.
---@param bufnr integer
---@return string[]
M.servers = function(bufnr)
  local ft = vim.bo[bufnr].filetype

  return servers[ft] or {}
end

M.default_config = {
  capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    capabilities
  ),
  root_dir = M.root_dir(),
}

return M
