---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  enabled = false,
  event = "VeryLazy",
  config = function()
    local lemminx_config = require("lspconfig.server_configurations.lemminx").default_config
    local lspconfig = require("lspconfig")
    local lspconfig_windows = require("lspconfig.ui.windows")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local schemastore = require("schemastore")
    local Path = require("plenary.path")

    lspconfig_windows.default_options.border = "rounded"

    local servers = {
      "awk_ls",
      "bashls",
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
      ensure_installed = vim.tbl_filter(on_system, servers),
      automatic_installation = false,
    })

    lspconfig.awk_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.bashls.setup({
      capabilities = capabilities,
      settings = {
        bashIde = {
          globPattern = "*@(.sh|.inc|.bash|.command|.subr)",
        },
      },
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

    -- https://cs.opensource.google/go/x/tools/+/master:gopls/doc/
    lspconfig.gopls.setup({
      capabilities = capabilities,
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
    })

    lspconfig.html.setup({
      capabilities = capabilities,
    })

    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = schemastore.json.schemas({
            extras = {
              {
                name = "LuaLS Settings",
                url = "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json",
                fileMatch = { ".luarc.json", ".luarc.jsonc" },
              },
            },
          }),
          validate = {
            enable = true,
          },
        },
      },
    })

    lspconfig.lemminx.setup({
      filetypes = { unpack(lemminx_config.filetypes), "sgml" },
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
      ---@param client lsp.Client
      on_init = function(client)
        local path = Path:new(client.workspace_folders[1].name)

        if path:joinpath(".luarc.json"):exists() or path:joinpath(".luarc.jsonc"):exists() then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          globals = {
            "vim",
          },
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              "${3rd}/luv/library",
              unpack(vim.api.nvim_get_runtime_file("", true)),
            },
          },
        })
      end,
    })

    lspconfig.marksman.setup({
      capabilities = capabilities,
    })

    -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      },
      ---@param client lsp.Client
      on_init = function(client)
        local path = Path:new(client.workspace_folders[1].name)

        if path:joinpath("poetry.lock"):exists() and vim.fn.executable("poetry") then
          client.config.settings.python =
            vim.tbl_deep_extend("force", client.config.settings.python, {
              venvPath = vim.fn.system("poetry env info --path"),
            })
        end
      end,
    })

    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          check = {
            extraArgs = {
              "--target-dir=target/analyzer",
            },
          },
          server = {
            extraEnv = {
              CARGO_TARGET_DIR = "target/analyzer",
            },
          },
        },
      },
    })

    lspconfig.swift_mesonls.setup({
      capabilities = capabilities,
    })

    lspconfig.taplo.setup({
      capabilities = capabilities,
    })

    lspconfig.terraformls.setup({
      capabilities = capabilities,
    })

    lspconfig.tsserver.setup({
      capabilities = capabilities,
    })

    lspconfig.typst_lsp.setup({
      capabilities = capabilities,
    })

    lspconfig.vimls.setup({
      capabilities = capabilities,
    })

    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = schemastore.yaml.schemas(),
        },
      },
    })

    lspconfig.zls.setup({
      capabilities = capabilities,
    })
  end,
}
