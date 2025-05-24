local M = {}

-- Register the tiltfile filetype as starlark
vim.treesitter.language.register("starlark", "tiltfile")

M.augroup = vim.api.nvim_create_augroup("tristan957_treesitter", { clear = true })

return M
