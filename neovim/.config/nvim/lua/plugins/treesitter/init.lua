---@module "lazy"
---@module "nvim-treesitter"

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "bezhermoso/tree-sitter-ghostty",
      build = "make nvim_install",
    },
  },
  cmd = { "TSInstall", "TSUninstall", "TSUpdate", "TSUpdateSync" },
  event = { "BufReadPre", "BufNewFile" },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = {
      "asm",
      "bash",
      "blueprint",
      "c",
      "cmake",
      "cpp",
      "css",
      "csv",
      "desktop",
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
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "gowork",
      "gpg",
      "graphql",
      "hare",
      "hcl",
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
      "kdl",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "meson",
      "nginx",
      "ninja",
      "objdump",
      "passwd",
      "perl",
      "po",
      "printf",
      "properties",
      "pymanifest",
      "python",
      "query",
      "readline",
      "regex",
      "requirements",
      "robots",
      "rust",
      "scfg",
      "scss",
      "sql",
      "ssh_config",
      "starlark",
      "superhtml",
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
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "dockerfile" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  config = function(_, opts)
    local context = require("treesitter-context")

    require("nvim-treesitter.configs").setup(opts)

    context.setup({
      separator = "─",
      on_attach = function()
        return true
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local ok, _ = pcall(vim.treesitter.get_parser, ev.buf)
        if not ok then
          return
        end

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        vim.keymap.set("n", "<C-w>C", context.toggle, { buffer = ev.buf, desc = "Toggle context" })
        vim.keymap.set("n", "[C", function()
          context.go_to_context(vim.v.count1)
        end, { buffer = ev.buf, silent = true, desc = "Jump to context" })
      end,
    })
  end,
}
