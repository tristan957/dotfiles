---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
    "cmp-nvim-lsp",
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = "VeryLazy",
  config = function()
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
      "dockerls",
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

    local on_system = function(s)
      return vim.fn.executable(lspconfig[s].document_config.default_config.cmd[1]) ~= 1
    end

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_filter(on_system, servers),
      automatic_installation = false,
    })

    -- Customize floating windows
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    local group = vim.api.nvim_create_augroup("tristan957/lspconfig", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "|I", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "|r", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "|i", vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set("n", "|o", vim.lsp.buf.outgoing_calls, opts)

        vim.keymap.set({ "n", "v" }, "<A-.>", vim.lsp.buf.code_action, opts)
      end,
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
      capabilities = capabilities,
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = "Disable",
            preloadFileSize = 200,
          },
        },
      },
      capabilities = capabilities,
      on_init = function(client)
        local path = Path:new(client.workspace_folders[1].name)

        if
          not path:joinpath(".luarc.json"):exists()
          and not path:joinpath(".luarc.jsonc"):exists()
        then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              globals = {
                "vim",
              },
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end

        return true
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
      on_init = function(client)
        local path = Path:new(client.workspace_folders[1].name)

        if path:joinpath("poetry.lock"):exists() and vim.fn.executable("poetry") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            python = {
              venvPath = vim.fn.system("poetry env info --path"),
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
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
