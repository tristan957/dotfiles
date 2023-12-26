local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { noremap = true })
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { noremap = true })

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.server_capabilities.goto_definition then
    buf_set_option("tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  if client.server_capabilities.document_formatting then
    buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr")
  end
end

require("mason-lspconfig").setup({
  ensure_installed = {
    "awk_ls",
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "denols",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "lua_ls",
    "ruff_lsp",
    "rust_analyzer",
    "terraformls",
    "vimls",
    "yamlls",
    "zls",
  },
  automatic_installation = true,
})

lspconfig.awk_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.bashls.setup({
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.subr)",
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--header-insertion=never",
    "--all-scopes-completion=false",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--enable-config",
    "--pch-storage=disk",
    "--header-insertion-decorators",
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.cmake.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.denols.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})

lspconfig.dockerls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.jdtls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.ruff_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        preloadFileSize = 200,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
  local path = client.workspace_folders[1].name
  if
    not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
  then
    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    })

    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end
  return true
  end
})

lspconfig.swift_mesonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.terraformls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("package.json"),
})

lspconfig.vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
