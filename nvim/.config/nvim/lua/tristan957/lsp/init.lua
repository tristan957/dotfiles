---@param client lsp.Client
---@return boolean
local function server_should_format(client)
  return vim.tbl_contains({
    "rust_analyzer",
  }, client.name)
end

local group = vim.api.nvim_create_augroup("tristan957/lsp", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(ev)
    local utils = require("tristan957.lsp.utils")

    local servers = utils.servers(ev.buf)

    for _, s in pairs(servers) do
      local config = require("tristan957.lsp.config." .. s)
      config = vim.tbl_deep_extend("force", utils.default_config, config)

      pcall(vim.lsp.start, config, { bufnr = ev.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(ev)
    local builtin = require("telescope.builtin")
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.bo[ev.buf].formatexpr = "v:lua.vim.lsp.formatexpr"

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", builtin.lsp_definitions, "Goto definitions")
    map("n", "gD", vim.lsp.buf.declaration, "Goto declarations")
    map("n", "gy", builtin.lsp_type_definitions, "Goto type definitions")
    map("n", "gl", builtin.lsp_implementations, "Show implementations")
    map("n", "g]", builtin.lsp_references, "Show references")
    -- Telescope's implementation doesn't take you to the line number.
    -- https://github.com/nvim-telescope/telescope.nvim/issues/2939
    map("n", "g(", vim.lsp.buf.incoming_calls, "Show incoming calls")
    map("n", "g)", vim.lsp.buf.outgoing_calls, "Show outgoing calls")
    map("n", "K", vim.lsp.buf.hover, "Show hover documentation")
    map("n", "<C-K>", vim.lsp.buf.signature_help, "Show signature help")
    map("n", "<A-r>", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<A-.>", vim.lsp.buf.code_action, "View code actions")
    map(
      "n",
      "<leader>/",
      builtin.lsp_document_symbols,
      "Search document symbols"
    )
    map(
      "n",
      "<leader>@",
      builtin.lsp_dynamic_workspace_symbols,
      "Search workspace symbols"
    )

    -- If more than one formatter, use selection
    map({ "n", "v" }, "|f", function()
      local clients = vim.lsp.get_active_clients({ bufnr = ev.buf })
      local formatters = {}

      for _, c in pairs(clients) do
        if c.server_capabilities.documentFormattingProvider and server_should_format(c) then
          table.insert(formatters, c.name)
        end
      end

      if #formatters > 1 then
        vim.ui.select(formatters, { prompt = "Select a formatter" }, function(_, choice)
          if not choice then
            vim.notify(vim.log.levels.WARN, "No formatter selected")
            return
          end

          vim.lsp.buf.format({ async = true, name = formatters[choice] })
        end)
      else
        vim.lsp.buf.format({ async = true, name = formatters[1] })
      end
    end, "Format code")

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight <cword> references",
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        desc = "Clean <cword> reference highlights",
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if
        client.server_capabilities.documentFormattingProvider and server_should_format(client)
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format on save",
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = ev.buf,
            id = client.id,
          })
        end,
      })
    end
  end,
})

require("tristan957.lsp.handlers")
