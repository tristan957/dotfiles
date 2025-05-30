---@module "lazy"
---@module "nvim-treesitter"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    "apple/pkl-neovim",
    "bezhermoso/tree-sitter-ghostty",
  },
  ---@type TSConfig | {}
  opts = {},
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
    require("nvim-treesitter").install({
      "asm",
      "bash",
      "blueprint",
      "c",
      "c_sharp",
      "cmake",
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
      "git_config",
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
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "jsonnet",
      "just",
      "kconfig",
      "kcl",
      "kdl",
      "lua",
      "luap",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "meson",
      "nginx",
      "ninja",
      "nix",
      "objdump",
      "passwd",
      "perl",
      "pkl",
      "po",
      "powershell",
      "printf",
      "prisma",
      "psv",
      "properties",
      "pymanifest",
      "python",
      "query",
      "readline",
      "regex",
      "requirements",
      "robots",
      "rust",
      -- "scfg",
      "scss",
      "sql",
      "ssh_config",
      "starlark",
      "strace",
      "superhtml",
      -- Deprecated
      -- "swift",
      "tmux",
      "toml",
      "tsv",
      "typescript",
      "typst",
      "vhs",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "zig",
      "ziggy",
      "ziggy_schema",
    }, {
      summary = false,
    } --[[@as InstallOptions]])

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      callback = function(ev)
        local ok, _ = vim.treesitter.language.add(vim.bo[ev.buf].filetype)
        if not ok then
          return
        end

        vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        vim.treesitter.start(ev.buf)
      end,
    })
  end,
}
