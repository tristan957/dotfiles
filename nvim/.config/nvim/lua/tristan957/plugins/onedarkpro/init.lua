require("onedarkpro").setup({
	dark_theme = "onedark_vivid",
	options = {
		bold = false,
		cursorline = true,
		italic = false,
		underline = false,
		undercurl = false,
	},
	highlights = {
		["@property.meson"] = { fg = "${white}" },
	},
})
