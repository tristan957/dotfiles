---@type PickerInterface
return {
  buffers = function()
    Snacks.picker.buffers()
  end,
  builtin = function()
    Snacks.picker.pick()
  end,
  command_history = function()
    Snacks.picker.command_history()
  end,
  diagnostics = function()
    Snacks.picker.diagnostics()
  end,
  explorer = function()
    Snacks.picker.explorer()
  end,
  files = function()
    Snacks.picker.smart({
      hidden = true,
    })
  end,
  git_bcommits = function()
    Snacks.picker.git_log()
  end,
  git_branches = function()
    Snacks.picker.git_branches()
  end,
  git_commits = function()
    Snacks.picker.git_log()
  end,
  git_diff = function()
    Snacks.picker.git_diff()
  end,
  git_stash = function()
    Snacks.picker.git_stash()
  end,
  git_tags = function() end,
  grep = function()
    Snacks.picker.grep({
      hidden = true,
    })
  end,
  help_tags = function()
    Snacks.picker.help()
  end,
  highlights = function()
    Snacks.picker.highlights()
  end,
  icons = function()
    Snacks.picker.icons()
  end,
  jumplist = function()
    Snacks.picker.jumps()
  end,
  keymaps = function()
    Snacks.picker.keymaps()
  end,
  loclist = function()
    Snacks.picker.loclist()
  end,
  loclist_history = function() end,
  lsp_declarations = function()
    Snacks.picker.lsp_declarations()
  end,
  lsp_definitions = function()
    Snacks.picker.lsp_definitions()
  end,
  lsp_document_symbols = function()
    Snacks.picker.lsp_symbols()
  end,
  lsp_implementations = function()
    Snacks.picker.lsp_implementations()
  end,
  lsp_incoming_calls = function() end,
  lsp_outgoing_calls = function() end,
  lsp_references = function()
    Snacks.picker.lsp_references()
  end,
  lsp_type_definitions = function()
    Snacks.picker.lsp_type_definitions()
  end,
  lsp_workspace_symbols = function()
    Snacks.picker.lsp_workspace_symbols()
  end,
  man_pages = function()
    Snacks.picker.man()
  end,
  marks = function()
    Snacks.picker.marks()
  end,
  notifications = function()
    Snacks.picker.notifications()
  end,
  quickfix = function()
    Snacks.picker.qflist()
  end,
  quickfix_history = function() end,
  registers = function()
    Snacks.picker.registers()
  end,
  resume = function()
    Snacks.picker.resume()
  end,
  search_history = function()
    Snacks.picker.search_history()
  end,
  tagstack = function() end,
  todo_comments = function()
    Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
  end,
  undo = function()
    Snacks.picker.undo()
  end,
}
