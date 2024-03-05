---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "folke/trouble.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
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
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<A-t>"] = trouble.open_with_trouble,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<A-l>"] = actions.send_to_loclist,
            ["<C-L>"] = actions.add_to_loclist,
            ["<C-Q>"] = actions.add_to_qflist,
          },
          n = {
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<A-t>"] = trouble.open_with_trouble,
            ["<C-l>"] = actions.send_selected_to_loclist,
            ["<A-l>"] = actions.send_to_loclist,
            ["<C-L>"] = actions.add_to_loclist,
            ["<C-Q>"] = actions.add_to_qflist,
            ["<Esc>"] = actions.close,
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
              ["<M-d>"] = actions.delete_buffer,
            },
            n = {
              ["<M-d>"] = actions.delete_buffer,
            },
          },
        },
        current_buffer_fuzzy_find = {
          previewer = false,
        },
        find_files = {
          prompt_title = "Files",
          hidden = true,
        },
        git_files = {
          prompt_title = "Files",
        },
        marks = {
          mappings = {
            i = {
              ["<A-d>"] = actions.delete_mark,
            },
            n = {
              ["<A-d>"] = actions.delete_mark,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = false,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          themes.get_dropdown({
            layout_strategy = "cursor",
          }),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("notify")
    telescope.load_extension("ui-select")

    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Open buffer" })
    vim.keymap.set("n", "<leader>p", builtin.builtin, { desc = "Open builtin picker" })
    vim.keymap.set("n", "<leader>c", builtin.command_history, { desc = "View command history" })
    vim.keymap.set(
      "n",
      "<leader>f",
      builtin.current_buffer_fuzzy_find,
      { desc = "Search in current buffer" }
    )
    vim.keymap.set("n", "<leader>w", builtin.diagnostics, { desc = "View diagnostics" })
    vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "View commits" })
    vim.keymap.set(
      "n",
      "<leader>gbc",
      builtin.git_bcommits,
      { desc = "View current buffer commits" }
    )
    vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "View git branches" })
    vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "View git stash" })
    vim.keymap.set(
      "n",
      "<leader>s",
      builtin.grep_string,
      { desc = "Search for string under the cursor" }
    )
    vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "View help tags" })
    vim.keymap.set("n", "<leader>j", builtin.jumplist, { desc = "View jumplist" })
    vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "View keymaps" })
    vim.keymap.set("n", "<leader>F", function()
      builtin.live_grep({
        additional_args = { "--hidden" },
        glob_pattern = {
          "!.git",
          "!node_modules",
        },
      })
    end, { desc = "Search for string" })
    vim.keymap.set("n", "<leader>l", builtin.loclist, { desc = "View location list" })
    vim.keymap.set("n", "<leader>mp", function()
      -- Note that mandb might need to be run, like if new man pages are added
      -- to $XDG_DATA_HOME/man.
      builtin.man_pages({ sections = { "ALL" } })
    end, { desc = "Open man pages" })
    vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "View marks" })
    vim.keymap.set("n", "<leader>qh", builtin.quickfixhistory, { desc = "View quickfix history" })
    vim.keymap.set("n", "<leader>q", builtin.quickfix, { desc = "View quickfix list" })
    vim.keymap.set("n", "<leader>r", builtin.registers, { desc = "View registers" })
    vim.keymap.set("n", "<leader>R", builtin.resume, { desc = "Resume last picker" })
    vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "Open search history" })
    vim.keymap.set("n", "<leader>t", builtin.tagstack, { desc = "Open tagstack" })

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

    vim.keymap.set("n", "<leader><leader>", project_files, { desc = "Open project files" })
  end,
}
