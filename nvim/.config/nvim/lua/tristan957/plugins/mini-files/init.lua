local mini_files = require("mini.files")

mini_files.setup({})

vim.keymap.set("n", "<leader>fb", mini_files.open, { noremap = true, silent = true })
