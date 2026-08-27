---@module "lazy"

---@type LazySpec
return {
  "tpope/vim-sleuth",
  event = { "BufNewFile", "BufReadPre" },
  init = function()
    vim.g.sleuth_gitcommit_heuristics = 0
    vim.g.sleuth_gitsendemail_heuristics = 0
    vim.g.sleuth_mail_heuristics = 0
  end,
}
