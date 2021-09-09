local cmp = require("cmp")

cmp.setup({
	autocomplete = cmp.TriggerEvent.TextChanged,
	sources = {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "emoji" },
		{ name = "calc" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		["<C-c>"] = cmp.mapping.close(),
		["<C-space>"] = cmp.mapping.complete(),
	},
	preselect = cmp.PreselectMode.Item,
	formatting = {
		deprecated = true,
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			-- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

			vim_item.menu = ({
				buffer = "[Buffer]",
				path = "[Path]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				emoji = "[Emoji]",
				calc = "[Calc]",
			})[entry.source.name]
			return vim_item
		end,
	},
})
