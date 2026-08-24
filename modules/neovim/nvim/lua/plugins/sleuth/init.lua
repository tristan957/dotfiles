---@module "lazy"

---@type LazySpec
return {
  "tpope/vim-sleuth",
  event = { "BufNewFile", "BufReadPre" },
  init = function()
    vim.g.sleuth_gitcommit_heurisitics = 0
    vim.g.sleuth_gitsendemail_heurisitics = 0
    vim.g.sleuth_mail_heurisitics = 0
  end,
}
