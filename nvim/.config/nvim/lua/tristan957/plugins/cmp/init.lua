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
    "hrsh7th/cmp-omni",
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
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = {
        "L3MON4D3/LuaSnip",
      },
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")
    local cmp_git = require("cmp_git")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    local window = cmp.config.window.bordered({
      border = "rounded",
      side_padding = 0,
      winhighlight = "CursorLine:Visual,Search:None",
    })

    cmp.setup({
      completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged },
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "path" },
        { name = "git" },
        { name = "emoji" },
        { name = "calc" },
      }, {
        { name = "buffer" },
      }),
      mapping = {
        ["<CR>"] = cmp.mapping({
          i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
        ["<C-c>"] = cmp.mapping({
          i = cmp.mapping.close(),
        }),
        ["<C-Space>"] = cmp.mapping({
          i = cmp.mapping.complete({ reason = cmp.ContextReason.Manual }),
        }),
        ["<Down>"] = cmp.mapping({
          i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        ["<Up>"] = cmp.mapping({
          i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        }),
        ["<C-n>"] = cmp.mapping({
          i = function()
            if cmp.visible() then
              cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end,
        }),
        ["<C-p>"] = cmp.mapping({
          i = function()
            if cmp.visible() then
              cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end,
        }),
        ["<C-d>"] = cmp.mapping({
          i = cmp.mapping.scroll_docs(-4),
        }),
        ["<C-f>"] = cmp.mapping({
          i = cmp.mapping.scroll_docs(4),
        }),
        ["<C-y>"] = cmp.mapping({
          i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          show_labelDetails = true,
        }),
      },
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
      { name = "luasnip" },
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
