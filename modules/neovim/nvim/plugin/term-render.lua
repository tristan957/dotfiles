vim.api.nvim_create_user_command("TermRender", function()
  vim.api.nvim_open_term(0, {})
end, {
  nargs = 0,
  desc = "Render current buffer in a terminal",
})
