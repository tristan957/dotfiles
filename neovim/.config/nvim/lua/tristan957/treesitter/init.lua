local M = {}

vim.treesitter.language.register("starlark", "tiltfile")

M.augroup = vim.api.nvim_create_augroup("tristan957_treesitter", { clear = true })

--- Get filetypes which have treesitter support according to my configuration.
---@return string[]
M.get_filetypes = function()
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
    "dockerfile",
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
