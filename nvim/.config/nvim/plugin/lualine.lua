require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "powerline",
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_b = {
			"branch",
			"diff",
		},
		lualine_c = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				colored = false,
				sections = { "error", "warn", "info", "hint" },
				diagnostics_color = {
					error = nil,
					warn = nil,
					info = nil,
					hint = nil,
				},
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				always_visible = true,
				update_in_insert = false,
				color = nil,
			},
			"filename",
			require("lsp-status").status,
		},
	},
})
