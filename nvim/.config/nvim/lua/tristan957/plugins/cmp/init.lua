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
	nvim_lua = "[Lua]",
	path = "[Path]",
}

cmp.setup({
	autocomplete = cmp.TriggerEvent.TextChanged,
	sources = {
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "path" },
		{ name = "git" },
		{ name = "luasnip" },
		{ name = "neorg" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "omni" },
		{ name = "buffer" },
	},
	mapping = {
		["<CR>"] = {
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		},
		["<C-c>"] = {
			i = cmp.mapping.close(),
		},
		["<C-space>"] = {
			i = cmp.mapping.complete({ reason = "manual" }),
		},
		["<Down>"] = {
			i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		},
		["<Up>"] = {
			i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		},
		["<C-n>"] = {
			i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		},
		["<C-p>"] = {
			i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		},
		["<C-y>"] = {
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		},
		["<C-e>"] = {
			i = cmp.mapping.abort(),
		},
	},
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		deprecated = true,
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

cmp.setup.cmdline(":", {
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
	mapping = {
		["<CR>"] = {
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		},
		["<Tab>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					feedkeys.call(keymap.t("<C-z>"), "n")
				end
			end,
		},
		["<S-Tab>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					feedkeys.call(keymap.t("<C-z>"), "n")
				end
			end,
		},
		["<C-n>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end,
		},
		["<C-p>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end,
		},
		["<C-e>"] = {
			c = cmp.mapping.close(),
		},
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
		{ name = "nvim_lsp_document_symbol" },
	},
	mapping = {
		["<CR>"] = {
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		},
		["<Tab>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					feedkeys.call(keymap.t("<C-z>"), "n")
				end
			end,
		},
		["<S-Tab>"] = {
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					feedkeys.call(keymap.t("<C-z>"), "n")
				end
			end,
		},
		["<C-n>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end,
		},
		["<C-p>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end,
		},
		["<C-e>"] = {
			c = cmp.mapping.close(),
		},
	},
})

cmp_git.setup()
