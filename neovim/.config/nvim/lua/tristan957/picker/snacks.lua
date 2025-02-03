---@diagnostic disable: missing-fields

---@type PickerInterface
return {
  buffers = function()
    require("snacks").picker.buffers()
  end,
  builtin = function()
    require("snacks").picker.pick()
  end,
  command_history = function()
    require("snacks").picker.command_history()
  end,
  diagnostics = function()
    require("snacks").picker.diagnostics()
  end,
  files = function()
    require("snacks").picker.files({
      hidden = true,
    })
  end,
  git_bcommits = function()
    require("snacks").picker.git_log()
  end,
  git_branches = function()
    require("snacks").picker.git_branches()
  end,
  git_commits = function()
    require("snacks").picker.git_log()
  end,
  git_stash = function()
    require("snacks").picker.git_stash()
  end,
  git_tags = function() end,
  grep = function()
    require("snacks").picker.grep()
  end,
  help_tags = function()
    require("snacks").picker.help()
  end,
  highlights = function()
    require("snacks").picker.highlights()
  end,
  jumplist = function()
    require("snacks").picker.jumps()
  end,
  keymaps = function()
    require("snacks").picker.keymaps()
  end,
  loclist = function()
    require("snacks").picker.loclist()
  end,
  loclist_history = function() end,
  lsp_declarations = function()
    require("snacks").picker.lsp_declarations()
  end,
  lsp_definitions = function()
    require("snacks").picker.lsp_definitions()
  end,
  lsp_document_symbols = function()
    require("snacks").picker.lsp_symbols()
  end,
  lsp_implementations = function()
    require("snacks").picker.lsp_implementations()
  end,
  lsp_incoming_calls = function() end,
  lsp_outgoing_calls = function() end,
  lsp_references = function()
    require("snacks").picker.lsp_references()
  end,
  lsp_type_definitions = function()
    require("snacks").picker.lsp_type_definitions()
  end,
  lsp_workspace_symbols = function() end,
  man_pages = function()
    require("snacks").picker.man()
  end,
  marks = function()
    require("snacks").picker.marks()
  end,
  quickfix = function()
    require("snacks").picker.qflist()
  end,
  quickfix_history = function() end,
  registers = function()
    require("snacks").picker.registers()
  end,
  resume = function()
    require("snacks").picker.resume()
  end,
  search_history = function()
    require("snacks").picker.search_history()
  end,
  tagstack = function() end,
}
