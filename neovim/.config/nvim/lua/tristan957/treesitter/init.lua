local M = {}

M.augroup = vim.api.nvim_create_augroup("tristan957_treesitter", { clear = true })

--- Check if a tree-sitter parser is available for the filetype
---@param ft string
---@return boolean
M.has_parser = function(ft)
  return pcall(vim.treesitter.language.add, vim.treesitter.language.get_lang(ft) or ft)
end

--- Check whether the tree-sitter CLI is available
---@return boolean
M.is_cli_available = function()
  return vim.fn.executable("tree-sitter") == 1
end

--- Get filetypes which have treesitter support according to my configuration.
---@return string[]
M.get_filetypes = function()
  if not M.is_cli_available() then
    return {}
  end

  return {
    "asm",
    "bash",
    "blueprint",
    "c",
    "c_sharp",
    "cmake",
    "codecompanion",
    "comment",
    "cpp",
    "css",
    "csv",
    "desktop",
    "dhall",
    "diff",
    -- This grammar sucks ass
    -- "dockerfile",
    "doxygen",
    "editorconfig",
    "fish",
    "ghostty",
    "gitconfig",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "gleam",
    "glsl",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "gpg",
    "graphql",
    "hare",
    "hcl",
    "helm",
    "html",
    "http",
    "ini",
    "java",
    "javascript",
    "jq",
    "json",
    "json.openapi",
    "json5",
    "jsonc",
    "jsonnet",
    "just",
    "kconfig",
    "kcl",
    "kdl",
    "lua",
    "make",
    "markdown",
    "meson",
    "nginx",
    "nix",
    "objdump",
    "passwd",
    "perl",
    "pkl",
    "po",
    "powershell",
    "prisma",
    "psv",
    "properties",
    "pymanifest",
    "python",
    "query",
    "readline",
    "requirements",
    "robots",
    "rust",
    -- "scfg",
    "scss",
    "sh",
    "sql",
    "sshconfig",
    "starlark",
    "strace",
    "superhtml",
    "swift",
    "tiltfile",
    "tmux",
    "toml",
    "tsv",
    "typescript",
    "typst",
    "vhs",
    "vim",
    "xml",
    "yaml",
    "yaml.openapi",
    "zig",
    "ziggy",
    "ziggy_schema",
  }
end

return M
