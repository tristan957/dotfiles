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
      --This grammar sucks ass
      --"dockerfile",
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
      "scfg",
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
