---@class PickerInterface
---@field buffers function()
---@field builtin function()
---@field command_history function()
---@field diagnostics function()
---@field explorer function()
---@field files function()
---@field git_commits function()
---@field git_bcommits function()
---@field git_branches function()
---@field git_diff function()
---@field git_stash function()
---@field git_tags? function()
---@field grep function()
---@field help_tags function()
---@field highlights function()
---@field icons function()
---@field jumplist function()
---@field keymaps function()
---@field loclist function()
---@field loclist_history function()
---@field lsp_declarations function()
---@field lsp_definitions function()
---@field lsp_document_symbols function()
---@field lsp_implementations function()
---@field lsp_incoming_calls function()
---@field lsp_outgoing_calls function()
---@field lsp_references function()
---@field lsp_type_definitions function()
---@field lsp_workspace_symbols function()
---@field man_pages function()
---@field marks function()
---@field notifications function()
---@field quickfix function()
---@field quickfix_history function()
---@field registers function()
---@field resume function()
---@field search_history function()
---@field tagstack function()
---@field todo_comments function()

local M = require("tristan957.picker.snacks")

vim.keymap.set("n", "<leader>b", M.buffers, { desc = "Open buffer" })
vim.keymap.set("n", "<leader>c", M.command_history, { desc = "View command history" })
vim.keymap.set("n", "<leader>w", M.diagnostics, { desc = "View diagnostics" })
vim.keymap.set("n", "<leader>gc", M.git_commits, { desc = "View commits" })
vim.keymap.set("n", "<leader>gC", M.git_bcommits, { desc = "View current buffer commits" })
vim.keymap.set("n", "<leader>gb", M.git_branches, { desc = "View git branches" })
vim.keymap.set("n", "<leader>gd", M.git_diff, { desc = "View git diff" })
vim.keymap.set("n", "<leader>gs", M.git_stash, { desc = "View git stash" })
vim.keymap.set("n", "<leader>h", M.help_tags, { desc = "View help tags" })
vim.keymap.set("n", "<leader>i", M.icons, { desc = "View icons" })
vim.keymap.set("n", "<leader>j", M.jumplist, { desc = "View jumplist" })
vim.keymap.set("n", "<leader>k", M.keymaps, { desc = "View keymaps" })
vim.keymap.set("n", "<leader>/", M.grep, { desc = "Search for string" })
vim.keymap.set("n", "<leader>l", M.loclist, { desc = "View location list" })
vim.keymap.set("n", "<leader>L", M.loclist_history, { desc = "View location list" })
vim.keymap.set("n", "<leader>M", M.man_pages, { desc = "Open man pages" })
vim.keymap.set("n", "<leader>m", M.marks, { desc = "View marks" })
vim.keymap.set("n", "<leader>n", M.notifications, { desc = "View notifications" })
vim.keymap.set("n", "<leader>q", M.quickfix, { desc = "View quickfix list" })
vim.keymap.set("n", "<leader>Q", M.quickfix_history, { desc = "View quickfix history" })
vim.keymap.set("n", "<leader>r", M.registers, { desc = "View registers" })
vim.keymap.set("n", "<leader>R", M.resume, { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>sh", M.search_history, { desc = "Open search history" })
vim.keymap.set("n", "<leader>T", M.tagstack, { desc = "Open tagstack" })
vim.keymap.set("n", "<leader>t", M.todo_comments, { desc = "Open TODO comments" })
vim.keymap.set("n", "<leader><leader>", M.files, { desc = "Find files" })

return M
