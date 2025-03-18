---@module "lazy"

---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  enabled = true,
  dependencies = {
    "Saghen/blink.cmp",
  },
  event = "VeryLazy",
  config = function()
    local systemd = require("tristan957.utils.systemd")
    local lspconfig = require("lspconfig")
    local lspconfig_windows = require("lspconfig.ui.windows")

    lspconfig_windows.default_options.border = "rounded"

    --- Wrap the language server command in systemd-run(1)
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
      biome = require("tristan957.lsp.config.biome"),
      blueprint_ls = require("tristan957.lsp.config.blueprint"),
      clangd = require("tristan957.lsp.config.clangd"),
      cmake = require("tristan957.lsp.config.cmake-language-server"),
      cssls = require("tristan957.lsp.config.vscode-css-languageserver"),
      denols = require("tristan957.lsp.config.deno"),
      dockerls = require("tristan957.lsp.config.dockerfile-language-server"),
      gleam = require("tristan957.lsp.config.gleam"),
      gopls = require("tristan957.lsp.config.gopls"),
      harper_ls = require("tristan957.lsp.config.harper-ls"),
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
      systemd_ls = require("tristan957.lsp.config.systemd-language-server"),
      taplo = require("tristan957.lsp.config.taplo"),
      terraformls = require("tristan957.lsp.config.terraform-ls"),
      tilt_ls = require("tristan957.lsp.config.tilt"),
      ts_ls = require("tristan957.lsp.config.typescript-language-server"),
      tinymist = require("tristan957.lsp.config.tinymist"),
      vacuum = require("tristan957.lsp.config.vacuum"),
      vimls = require("tristan957.lsp.config.vim-language-server"),
      yamlls = require("tristan957.lsp.config.yaml-language-server"),
      zls = require("tristan957.lsp.config.zls"),
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    for key, config in pairs(configs) do
      config.capabilities = capabilities

      lspconfig[key].setup(wrap_in_systemd_run(key, config))
    end
  end,
}
