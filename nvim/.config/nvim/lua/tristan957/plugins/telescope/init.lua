---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "folke/trouble.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "rcarriga/nvim-notify",
    "ThePrimeagen/refactoring.nvim",
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")
    local trouble = require("trouble.providers.telescope")

    telescope.setup({
      defaults = {
        color_devicons = true,
        mappings = {
          i = {
            ["<M-t>"] = trouble.open_with_trouble,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<M-l>"] = actions.send_to_loclist,
            ["<C-S-l>"] = actions.add_to_loclist,
            ["<C-S-q>"] = actions.add_to_qflist,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<M-t>"] = trouble.open_with_trouble,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<M-l>"] = actions.send_to_loclist,
            ["<C-S-l>"] = actions.add_to_loclist,
            ["<C-S-q>"] = actions.add_to_qflist,
          },
        },
      },
      pickers = {
        builtin = {
          previewer = false,
        },
        buffers = {
          mappings = {
            i = {
              ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
            },
            n = {
              ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
        find_files = {
          prompt_title = "Files",
          hidden = true,
        },
        git_files = {
          prompt_title = "Files",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = themes.get_dropdown({}),
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("notify")
    telescope.load_extension("ui-select")

    vim.keymap.set("n", "<leader>a", builtin.autocommands, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>b", builtin.buffers, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>p", builtin.builtin, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>c", builtin.commands, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ch", builtin.command_history, { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<leader>f",
      builtin.current_buffer_fuzzy_find,
      { noremap = true, silent = true }
    )
    vim.keymap.set("n", "<leader>w", builtin.diagnostics, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gt", builtin.git_stash, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>s", builtin.grep_string, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>h", builtin.help_tags, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>j", builtin.jumplist, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>k", builtin.keymaps, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>F", builtin.live_grep, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>l", builtin.loclist, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>D", builtin.lsp_definitions, { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<leader>2",
      builtin.lsp_document_symbols,
      { noremap = true, silent = true }
    )
    vim.keymap.set("n", "<leader>I", builtin.lsp_implementations, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>i", builtin.lsp_incoming_calls, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>o", builtin.lsp_outgoing_calls, { noremap = true, silent = true })
    vim.keymap.set(
      "n",
      "<leader>T",
      builtin.lsp_type_definitions,
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>@",
      builtin.lsp_dynamic_workspace_symbols,
      { noremap = true, silent = true }
    )
    vim.keymap.set("n", "<leader>mp", builtin.man_pages, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>m", builtin.marks, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>op", builtin.oldfiles, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>qh", builtin.quickfixhistory, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>q", builtin.quickfix, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>r", builtin.registers, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>sh", builtin.search_history, { noremap = true, silent = true })

    -- We cache the results of "git rev-parse"
    -- Process creation is expensive in Windows, so this reduces latency
    local is_inside_work_tree = {}

    local project_files = function()
      local opts = {}

      local cwd = vim.fn.getcwd()
      if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
      end

      if is_inside_work_tree[cwd] then
        builtin.git_files(vim.tbl_extend("force", opts, { show_untracked = true }))
      else
        builtin.find_files(vim.tbl_extend("force", opts, { hidden = true }))
      end
    end

    vim.keymap.set("n", "<leader><leader>", project_files, { noremap = true, silent = true })
  end,
}
