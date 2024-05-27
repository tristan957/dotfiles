---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "nvim-neorg/neorg",
    "onsails/lspkind.nvim",
    {
      "petertriho/cmp-git",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    {
      "rcarriga/cmp-dap",
      dependencies = {
        "mfussenegger/nvim-dap",
      },
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")
    local cmp_git = require("cmp_git")
    local lspkind = require("lspkind")

    local window = cmp.config.window.bordered({
      border = "rounded",
      side_padding = 0,
      winhighlight = "CursorLine:Visual,Search:None",
    })

    cmp.setup({
      completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged },
        completeopt = "menu,menuone,noinsert",
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          show_labelDetails = true,
        }),
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-y>"] = cmp.mapping({
          i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
        ["<C-Space>"] = cmp.mapping({
          i = cmp.mapping.complete({ reason = cmp.ContextReason.Manual }),
        }),
        ["<C-c>"] = cmp.mapping({
          i = cmp.mapping.close(),
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-l>"] = cmp.mapping(function()
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          end
        end, { "i", "s" }),
      },
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.scopes,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
    },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" },
        { name = "git" },
        { name = "emoji" },
        { name = "calc" },
      }, {
        { name = "buffer" },
      }),
      window = {
        completion = window,
        documentation = window,
      },
      view = {
        entries = "custom",
      },
    })

    cmp_git.setup({})

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.filetype("neorg", {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "neorg" },
      { name = "path" },
      { name = "git" },
      { name = "emoji" },
      { name = "calc" },
    }, {
      { name = "buffer" },
    })

    local cmdline_mappings = {
      ["<Tab>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),
      ["<S-Tab>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),
      ["<C-n>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),
      ["<C-p>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),
      ["<C-e>"] = cmp.mapping({
        c = cmp.mapping.abort(),
      }),
      ["<C-y>"] = cmp.mapping({
        c = cmp.mapping.confirm({ select = false }),
      }),
      ["<C-z>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end,
      }),
    }

    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "cmdline" },
      }, {
        { name = "path" },
      }),
      mapping = cmdline_mappings,
    })

    cmp.setup.cmdline({ "/", "?" }, {
      sources = cmp.config.sources({
        { name = "buffer" },
      }, {
        { name = "nvim_lsp_document_symbol" },
      }),
      mapping = cmdline_mappings,
    })
  end,
}
