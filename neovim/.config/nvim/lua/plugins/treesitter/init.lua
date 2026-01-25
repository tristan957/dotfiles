---@module "lazy"
---@module "nvim-treesitter"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  cond = require("tristan957.treesitter").is_cli_available(),
  build = ":TSUpdate",
  dependencies = {
    "bezhermoso/tree-sitter-ghostty",
  },
  ---@type TSConfig | {}
  opts = {},
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    require("nvim-treesitter").install({
      "arduino",
      "asm",
      "awk",
      "bash",
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
      "disassembly",
      --This grammar sucks ass
      --"dockerfile",
      "doxygen",
      "dtd",
      "editorconfig",
      "fish",
      "fortran",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "gleam",
      "glsl",
      "gn",
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
      "javadoc",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "json5",
      "jsonnet",
      "just",
      "kcl",
      "kconfig",
      "kdl",
      "linkerscript",
      "lua",
      "luadoc",
      "luap",
      "luau",
      "make",
      "markdown",
      "markdown_inline",
      "mermaid",
      "meson",
      "nginx",
      "ninja",
      "nix",
      "nu",
      "objdump",
      "passwd",
      "pem",
      "perl",
      "pkl",
      "po",
      "powershell",
      "printf",
      "prisma",
      "promql",
      "proto",
      "promql",
      "properties",
      "prql",
      "psv",
      "pymanifest",
      "python",
      "ql",
      "query",
      "readline",
      "regex",
      "requirements",
      "robots_txt",
      "ron",
      "rst",
      "rust",
      "scfg",
      "scss",
      "scheme",
      "sql",
      "ssh_config",
      "starlark",
      "strace",
      "superhtml",
      "sway",
      "swift",
      "terraform",
      "tmux",
      "toml",
      "tsv",
      "tsx",
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
      "zsh",
    }, {
      summary = false,
    } --[[@as InstallOptions]])

    vim.api.nvim_create_autocmd("FileType", {
      group = require("tristan957.treesitter").augroup,
      callback = function(ev)
        local filetype = ev.match

        if not require("tristan957.treesitter").has_parser(filetype) then
          return
        end

        vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"

        vim.treesitter.start(ev.buf)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").ghactions = {
          tier = 0,
          install_info = {
            url = "https://github.com/rmuir/tree-sitter-ghactions",
            revision = "main",
            queries = "queries",
          },
        }
      end,
    })
  end,
}
