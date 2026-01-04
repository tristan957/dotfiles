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
      "asm",
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
      "editorconfig",
      "fish",
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
      "jsonnet",
      "jsx",
      "just",
      "kconfig",
      "kcl",
      "kdl",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "mermaid",
      "meson",
      "ninja",
      "nginx",
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
      "promql",
      "properties",
      "pymanifest",
      "python",
      "query",
      "readline",
      "regex",
      "requirements",
      "robots_txt",
      "rust",
      "scfg",
      "scss",
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
