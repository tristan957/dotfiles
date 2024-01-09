local cmp = require("cmp")
local cmp_git = require("cmp_git")
local feedkeys = require("cmp.utils.feedkeys")
local keymap = require("cmp.utils.keymap")

local sources = {
  buffer = "[Buffer]",
  calc = "[Calc]",
  emoji = "[Emoji]",
  luasnip = "[Snippet]",
  neorg = "[Neorg]",
  nvim_lsp = "[LSP]",
  path = "[Path]",
  git = "[Git]",
}

cmp.setup({
  completion = {
    autocomplete = { cmp.TriggerEvent.TextChanged },
  },
  sources = cmp.config.sources({
    { name = "calc" },
    { name = "emoji" },
    { name = "path" },
    { name = "git" },
    { name = "luasnip" },
    { name = "neorg" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "omni" },
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
    ["<C-space>"] = cmp.mapping({
      i = cmp.mapping.complete({ reason = cmp.ContextReason.Manual }),
    }),
    ["<Down>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    ["<Up>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    ["<C-n>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    ["<C-p>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    ["<C-y>"] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
    }),
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      local detail = entry:get_completion_item().detail

      if detail == nil then
        vim_item.menu = sources[entry.source.name]
      else
        vim_item.menu = sources[entry.source.name] .. " " .. detail
      end

      return vim_item
    end,
  },
})

cmp_git.setup({})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline" },
  }, {
    { name = "path" },
  }),
  mapping = {
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          feedkeys.call(keymap.t("<C-z>"), "n")
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          feedkeys.call(keymap.t("<C-z>"), "n")
        end
      end,
    }),
    ["<C-n>"] = cmp.mapping({
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-e>"] = cmp.mapping({
      c = cmp.mapping.close(),
    }),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  sources = cmp.config.sources({
    { name = "buffer" },
  }, {
    { name = "nvim_lsp_document_symbol" },
  }),
  mapping = {
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          feedkeys.call(keymap.t("<C-z>"), "n")
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          feedkeys.call(keymap.t("<C-z>"), "n")
        end
      end,
    }),
    ["<C-n>"] = cmp.mapping({
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-p>"] = cmp.mapping({
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ["<C-e>"] = cmp.mapping({
      c = cmp.mapping.close(),
    }),
  },
})
