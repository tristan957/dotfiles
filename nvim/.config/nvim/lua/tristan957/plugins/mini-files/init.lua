local mini_files = require("mini.files")

mini_files.setup({
  use_as_default_explorer = true,
})

vim.keymap.set("n", "<leader>n", function()
  mini_files.open(vim.api.nvim_buf_get_name(0))
end, { noremap = true, silent = true })
