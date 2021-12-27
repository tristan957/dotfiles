require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.concealer"] = {},
		["core.keybinds"] = {
			config = {
				default_keybinds = true,
				neorg_leader = "<Leader>o",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					root = os.getenv("HOME") .. "neorg",
				},
			},
		},
	},
})
