vim.keymap.set({ "i", "n", "v" }, "<A-U>", vim.cmd.nohlsearch, { desc = "Turn off search highlighting" })
vim.keymap.set({ "n", "v" }, "<A-/>", "<Esc>/\\%V", { desc = "Search within last selection" })
