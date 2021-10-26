local cmp = require("cmp")

local sources = {
	buffer = "[Buffer]",
	path = "[Path]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	emoji = "[Emoji]",
	calc = "[Calc]",
	luasnip = "[Snippet]",
}

cmp.setup({
	autocomplete = cmp.TriggerEvent.TextChanged,
	sources = {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "emoji" },
		{ name = "calc" },
		{ name = "luasnip" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
		["<C-c>"] = cmp.mapping.close(),
		["<C-space>"] = cmp.mapping.complete(),
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
