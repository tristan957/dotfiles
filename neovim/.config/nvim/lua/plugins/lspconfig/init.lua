---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
  },
  enabled = true,
  event = "VeryLazy",
  config = function()
    local lspconfig = require("lspconfig")
    local lspconfig_windows = require("lspconfig.ui.windows")

    lspconfig_windows.default_options.border = "rounded"

    local servers = {
      "awk_ls",
      "bashls",
      "basedpyright",
      "clangd",
      "cmake",
      "cssls",
      "denols",
      "gopls",
      "html",
      "jdtls",
      "lemminx",
      "lua_ls",
      "marksman",
      "pyright",
      "ruff_lsp",
      "rust_analyzer",
      "swift_mesonls",
      "taplo",
      "terraformls",
      "tsserver",
      "vimls",
      "yamlls",
      "zls",
    }

    ---@param s string
    ---@return boolean
    local on_system = function(s)
      return vim.fn.executable(lspconfig[s].document_config.default_config.cmd[1]) ~= 1
    end

    require("mason-lspconfig").setup({
      ensure_installed = vim.iter(servers):filter(on_system):totable(),
      automatic_installation = false,
    })

    lspconfig.awk_ls.setup(require("tristan957.lsp.config.awk-language-server"))
    lspconfig.basedpyright.setup(require("tristan957.lsp.config.basedpyright"))
    lspconfig.bashls.setup(require("tristan957.lsp.config.bash-language-server"))
    lspconfig.blueprint_ls.setup(require("tristan957.lsp.config.blueprint"))
    lspconfig.clangd.setup(require("tristan957.lsp.config.clangd"))
    lspconfig.cmake.setup(require("tristan957.lsp.config.cmake-language-server"))
    lspconfig.cssls.setup(require("tristan957.lsp.config.vscode-css-languageserver"))
    lspconfig.denols.setup(require("tristan957.lsp.config.deno"))
    lspconfig.gopls.setup(require("tristan957.lsp.config.gopls"))
    lspconfig.html.setup(require("tristan957.lsp.config.vscode-html-languageserver"))
    lspconfig.jsonls.setup(require("tristan957.lsp.config.vscode-json-languageserver"))
    lspconfig.lemminx.setup(require("tristan957.lsp.config.lemminx"))
    lspconfig.lua_ls.setup(require("tristan957.lsp.config.lua-language-server"))
    lspconfig.marksman.setup(require("tristan957.lsp.config.marksman"))
    lspconfig.mesonlsp.setup(require("tristan957.lsp.config.mesonlsp"))
    lspconfig.pyright.setup(require("tristan957.lsp.config.pyright"))
    lspconfig.ruff_lsp.setup(require("tristan957.lsp.config.ruff-lsp"))
    lspconfig.rust_analyzer.setup(require("tristan957.lsp.config.rust-analyzer"))
    lspconfig.taplo.setup(require("tristan957.lsp.config.taplo"))
    lspconfig.terraformls.setup(require("tristan957.lsp.config.terraform-ls"))
    lspconfig.tsserver.setup(require("tristan957.lsp.config.typescript-language-server"))
    lspconfig.typst_lsp.setup(require("tristan957.lsp.config.typst-lsp"))
    lspconfig.vimls.setup(require("tristan957.lsp.config.vim-language-server"))
    lspconfig.yamlls.setup(require("tristan957.lsp.config.yaml-language-server"))
    lspconfig.zls.setup(require("tristan957.lsp.config.yaml-language-server"))
  end,
}
