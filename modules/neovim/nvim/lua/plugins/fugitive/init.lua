---@module "lazy"

---@type LazySpec
return {
  "tpope/vim-fugitive",
  cmd = { "Git" },
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveCommit",
      desc = "Set up commit object buffer keymaps",
      callback = function(args)
        vim.keymap.set("n", "ys", function()
          local hash = vim.fn.FugitiveParse()[1]
          local register = vim.v.register

          vim.fn.setreg(register, hash)
          vim.notify(string.format('Yanked commit hash into register "%s: %s', register, hash))
        end, { buffer = args.buf, desc = "Yank the current commit's hash" })
      end,
    })
  end,
}
