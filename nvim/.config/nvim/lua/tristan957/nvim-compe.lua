vim.o.completeopt = "menuone,noselect"

require("compe").setup({
	enabled = true,
	autocomplete = true,
	min_length = 1,
	preselect = "enable",
	source = {
		path = true,
		buffer = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		emoji = true,
	},
})

vim.api.nvim_set_keymap(
	"i",
	"<C-c>",
	"compe#close('<C-c>')",
	{ noremap = true, silent = true, expr = true }
)
vim.api.nvim_set_keymap(
	"i",
	"<C-Space>",
	"compe#complete()",
	{ noremap = true, silent = true, expr = true }
)
