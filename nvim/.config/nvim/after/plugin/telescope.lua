local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		color_devicons = true,
		mappings = {
			i = {
				["<M-t>"] = trouble.open_with_trouble,
				["<C-u>"] = false,
			},
			n = {
				["<M-t>"] = trouble.open_with_trouble,
				["<C-u>"] = false,
			},
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

vim.api.nvim_set_keymap(
	"n",
	"<leader><S-p>",
	"<cmd>lua require('telescope.builtin').find_files()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>p",
	"<cmd>lua require('telescope.builtin').git_files()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>op",
	"<cmd>lua require('telescope.builtin').oldfiles()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>s",
	"<cmd>lua require('telescope.builtin').grep_string()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	"<cmd>lua require('telescope.builtin').file_browser({ hidden = true })<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vb",
	"<cmd>lua require('telescope.builtin').buffers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vm",
	"<cmd>lua require('telescope.builtin').marks()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vr",
	"<cmd>lua require('telescope.builtin').registers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vh",
	"<cmd>lua require('telescope.builtin').help_tags()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vl",
	"<cmd>lua require('telescope.builtin').loc_list()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vq",
	"<cmd>lua require('telescope.builtin').quickfix()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vsh",
	"<cmd>lua require('telescope.builtin').search_history()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>vch",
	"<cmd>lua require('telescope.builtin').command_history()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gc",
	"<cmd>lua require('telescope.builtin').git_commits()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gbc",
	"<cmd>lua require('telescope.builtin').git_bcommits()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gb",
	"<cmd>lua require('telescope.builtin').git_branches()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gt",
	"<cmd>lua require('telescope.builtin').git_stashes()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>mp",
	"<cmd>lua require('telescope.builtin').man_pages()<cr>",
	{ noremap = true, silent = true }
)
