local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		color_devicons = true,
		mappings = {
			i = { ["<M-t>"] = trouble.open_with_trouble },
			n = { ["<M-t>"] = trouble.open_with_trouble },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("git_worktree")
