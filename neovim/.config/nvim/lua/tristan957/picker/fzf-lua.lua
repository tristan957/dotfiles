---@type PickerInterface
return {
  buffers = require("fzf-lua").buffers,
  builtin = require("fzf-lua").builtin,
  command_history = require("fzf-lua").command_history,
  diagnostics = require("fzf-lua").diagnostics_workspace,
  files = require("fzf-lua").files,
  git_bcommits = require("fzf-lua").git_bcommits,
  git_branches = require("fzf-lua").git_branches,
  git_commits = require("fzf-lua").git_commits,
  git_stash = require("fzf-lua").git_stash,
  git_tags = require("fzf-lua").git_stash,
  grep = require("fzf-lua").live_grep_glob,
  help_tags = require("fzf-lua").helptags,
  highlights = require("fzf-lua").highlights,
  jumplist = require("fzf-lua").jumps,
  keymaps = require("fzf-lua").keymaps,
  loclist = require("fzf-lua").loclist,
  loclist_history = require("fzf-lua").loclist_stack,
  lsp_declarations = require("fzf-lua").lsp_declarations,
  lsp_definitions = require("fzf-lua").lsp_definitions,
  lsp_document_symbols = require("fzf-lua").lsp_document_symbols,
  lsp_implementations = require("fzf-lua").lsp_implementations,
  lsp_incoming_calls = require("fzf-lua").lsp_incoming_calls,
  lsp_outgoing_calls = require("fzf-lua").lsp_outgoing_calls,
  lsp_references = require("fzf-lua").lsp_references,
  lsp_type_definitions = require("fzf-lua").lsp_typedefs,
  lsp_workspace_symbols = require("fzf-lua").lsp_live_workspace_symbols,
  man_pages = require("fzf-lua").manpages,
  marks = require("fzf-lua").marks,
  quickfix = require("fzf-lua").quickfix,
  quickfix_history = require("fzf-lua").quickfix_stack,
  registers = require("fzf-lua").registers,
  resume = require("fzf-lua").resume,
  search_history = require("fzf-lua").search_history,
  tagstack = require("fzf-lua").tagstack,
}