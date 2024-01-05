local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
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
  "lemminx",
  "lua_ls",
  "ruff_lsp",
  "swift_mesonls",
  "terraformls",
  "tsserver",
  "vimls",
  "yamlls",
  "zls",
}

local on_system = function(s)
  return vim.fn.executable(lspconfig[s].document_config.default_config.cmd[1]) ~= 1
end

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_filter(on_system, servers),
  automatic_installation = true,
})

lspconfig.awk_ls.setup({
  capabilities = capabilities,
})

lspconfig.bashls.setup({
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.subr)",
  },
  capabilities = capabilities,
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
})

lspconfig.cmake.setup({
  capabilities = capabilities,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
})

lspconfig.denols.setup({
  capabilities = capabilities,
})

lspconfig.dockerls.setup({
  capabilities = capabilities,
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
})

lspconfig.html.setup({
  capabilities = capabilities,
})

lspconfig.jdtls.setup({
  capabilities = capabilities,
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
})

lspconfig.lemminx.setup({
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
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

lspconfig.ruff_lsp.setup({
  capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})

lspconfig.swift_mesonls.setup({
  capabilities = capabilities,
})

lspconfig.terraformls.setup({
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
})

lspconfig.vimls.setup({
  capabilities = capabilities,
})

lspconfig.yamlls.setup({
  capabilities = capabilities,
})

lspconfig.zls.setup({
  capabilities = capabilities,
})
