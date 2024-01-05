local group = vim.api.nvim_create_augroup("tristan957", { clear = true })

-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = group,
  callback = function()
    -- If we ask for trailing whitespace, respect it
    if string.find(vim.bo.formatoptions, "w") == nil then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Remove extra trailing newlines
local empty_line = vim.regex("^$")
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = group,
  callback = function(ev)
    local view = vim.fn.winsaveview()

    local line = vim.fn.line("$") - 1
    while empty_line:match_line(ev.buf, line) ~= nil do
      vim.cmd("$d")
      line = line - 1
    end

    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', "gDt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})
