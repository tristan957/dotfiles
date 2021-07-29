require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "powerline",
		component_separators = {"|", "|"},
		section_separators = "",
	},
	sections = {
		lualine_c = {
			"filename",
			require("lsp-status").status,
		},
	},
})
