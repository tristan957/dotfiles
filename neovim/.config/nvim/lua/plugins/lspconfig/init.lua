---@module "lazy"

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
    local systemd = require("tristan957.utils.systemd")
    local lspconfig = require("lspconfig")
    local lspconfig_windows = require("lspconfig.ui.windows")

    lspconfig_windows.default_options.border = "rounded"

    local servers = {
      "awk_ls",
      "basedpyright",
      "bashls",
      "blueprint_ls",
      "clangd",
      "cmake",
      "cssls",
      "denols",
      "gopls",
      "html",
      "jdtls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "marksman",
      "mesonlsp",
      "pyright",
      "ruff",
      "rust_analyzer",
      "taplo",
      "terraformls",
      "tinymist",
      "ts_ls",
      "vacuum",
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

    ---Wrap the language server command in systemd-run(1)
    ---@param config lspconfig.Config
    ---@param ls string
    ---@return lspconfig.Config
    local wrap_in_systemd_run = function(ls, config)
      local pid = vim.fn.getpid()

      ---@type SystemdRunOptions
      local options = {
        pipe = true,
        unit = "neovim-" .. pid .. "-" .. ls,
        quiet = true,
        same_dir = true,
        user = true,
        description = "A language server (" .. ls .. ") running for Neovim[" .. pid .. "]",
      }

      ---@type lspconfig.Config?
      local on_new_config = vim.tbl_get(config, "on_new_config")
      if on_new_config ~= nil then
        config.on_new_config = function(new_config, new_root_dir)
          on_new_config(new_config, new_root_dir)

          local cmd = new_config.cmd
          ---@cast cmd -function(dispatchers: vim.lsp.rpc.Dispatchers):vim.lsp.rpc.PublicClient
          new_config.cmd = systemd.wrap_with_run(cmd, options)
        end
      else
        config.on_new_config = function(new_config, _)
          local cmd = new_config.cmd
          ---@cast cmd -function(dispatchers: vim.lsp.rpc.Dispatchers):vim.lsp.rpc.PublicClient
          new_config.cmd = systemd.wrap_with_run(cmd, options)
        end
      end

      return config
    end

    ---@type { [string]: lspconfig.Config }
    local configs = {
      awk_ls = require("tristan957.lsp.config.awk-language-server"),
      basedpyright = require("tristan957.lsp.config.basedpyright"),
      bashls = require("tristan957.lsp.config.bash-language-server"),
      blueprint_ls = require("tristan957.lsp.config.blueprint"),
      clangd = require("tristan957.lsp.config.clangd"),
      cmake = require("tristan957.lsp.config.cmake-language-server"),
      cssls = require("tristan957.lsp.config.vscode-css-languageserver"),
      denols = require("tristan957.lsp.config.deno"),
      gleam = require("tristan957.lsp.config.gleam"),
      gopls = require("tristan957.lsp.config.gopls"),
      html = require("tristan957.lsp.config.vscode-html-languageserver"),
      jsonls = require("tristan957.lsp.config.vscode-json-languageserver"),
      jsonnet_ls = require("tristan957.lsp.config.jsonnet-language-server"),
      lemminx = require("tristan957.lsp.config.lemminx"),
      lua_ls = require("tristan957.lsp.config.lua-language-server"),
      marksman = require("tristan957.lsp.config.marksman"),
      mesonlsp = require("tristan957.lsp.config.mesonlsp"),
      pyright = require("tristan957.lsp.config.pyright"),
      ruff = require("tristan957.lsp.config.ruff"),
      rust_analyzer = require("tristan957.lsp.config.rust-analyzer"),
      taplo = require("tristan957.lsp.config.taplo"),
      terraformls = require("tristan957.lsp.config.terraform-ls"),
      ts_ls = require("tristan957.lsp.config.typescript-language-server"),
      tinymist = require("tristan957.lsp.config.tinymist"),
      vacuum = require("tristan957.lsp.config.vacuum"),
      vimls = require("tristan957.lsp.config.vim-language-server"),
      yamlls = require("tristan957.lsp.config.yaml-language-server"),
      zls = require("tristan957.lsp.config.zls"),
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    for key, config in pairs(configs) do
      config.capabilities = capabilities

      lspconfig[key].setup(wrap_in_systemd_run(key, config))
    end
  end,
}
