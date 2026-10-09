-- Add the Ghostty Neovim resources directory to the runtimepath
if vim.fn.has("mac") == 1 then
  vim.opt.runtimepath:append("/Applications/Ghostty.app/Contents/Resources/nvim/site")
end
