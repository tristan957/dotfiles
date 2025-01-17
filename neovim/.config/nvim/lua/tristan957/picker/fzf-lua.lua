---@type PickerInterface
return {
  buffers = function()
    require("fzf-lua").buffers()
  end,
  builtin = function()
    require("fzf-lua").builtin()
  end,
  command_history = function()
    require("fzf-lua").command_history()
  end,
  diagnostics = function()
    require("fzf-lua").diagnostics_workspace()
  end,
  files = function()
    require("fzf-lua").files()
  end,
  git_bcommits = function()
    require("fzf-lua").git_bcommits()
  end,
  git_branches = function()
    require("fzf-lua").git_branches()
  end,
  git_commits = function()
    require("fzf-lua").git_commits()
  end,
  git_stash = function()
    require("fzf-lua").git_stash()
  end,
  git_tags = function()
    require("fzf-lua").git_tags()
  end,
  grep = function()
    require("fzf-lua").live_grep_glob()
  end,
  help_tags = function()
    require("fzf-lua").helptags()
  end,
  highlights = function()
    require("fzf-lua").highlights()
  end,
  jumplist = function()
    require("fzf-lua").jumps()
  end,
  keymaps = function()
    require("fzf-lua").keymaps()
  end,
  loclist = function()
    require("fzf-lua").loclist()
  end,
  loclist_history = function()
    require("fzf-lua").loclist_stack()
  end,
  lsp_declarations = function()
    require("fzf-lua").lsp_declarations()
  end,
  lsp_definitions = function()
    require("fzf-lua").lsp_definitions()
  end,
  lsp_document_symbols = function()
    require("fzf-lua").lsp_document_symbols()
  end,
  lsp_implementations = function()
    require("fzf-lua").lsp_implementations()
  end,
  lsp_incoming_calls = function()
    require("fzf-lua").lsp_incoming_calls()
  end,
  lsp_outgoing_calls = function()
    require("fzf-lua").lsp_outgoing_calls()
  end,
  lsp_references = function()
    require("fzf-lua").lsp_references()
  end,
  lsp_type_definitions = function()
    require("fzf-lua").lsp_typedefs()
  end,
  lsp_workspace_symbols = function()
    require("fzf-lua").lsp_live_workspace_symbols()
  end,
  man_pages = function()
    require("fzf-lua").manpages()
  end,
  marks = function()
    require("fzf-lua").marks()
  end,
  quickfix = function()
    require("fzf-lua").quickfix()
  end,
  quickfix_history = function()
    require("fzf-lua").quickfix_stack()
  end,
  registers = function()
    require("fzf-lua").registers()
  end,
  resume = function()
    require("fzf-lua").resume()
  end,
  search_history = function()
    require("fzf-lua").search_history()
  end,
  tagstack = function()
    require("fzf-lua").tagstack()
  end,
}
