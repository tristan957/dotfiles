local extract_highlight_colors = require("lualine.utils.utils").extract_highlight_colors

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
			"filename",
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				diagnostics_color = {
					error = { fg = extract_highlight_colors("DiagnosticError", "fg") },
					warn = { fg = extract_highlight_colors("DiagnosticWarn", "fg") },
					info = { fg = extract_highlight_colors("DiagnosticInfo", "fg") },
					hint = { fg = extract_highlight_colors("DiagnosticHint", "fg") },
				},
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				always_visible = false,
				update_in_insert = true,
			},
			require("lsp-status").status,
		},
	},
})
