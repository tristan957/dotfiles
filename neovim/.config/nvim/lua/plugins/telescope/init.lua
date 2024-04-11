local ignore_these = {
  ".cache",
  ".DS_Store",
  ".git",
  ".hg",
  ".mypy_cache",
  ".pytest_cache",
  ".ruff_cache",
  ".svn",
  "__pycache__",
  "CVS",
  "node_modules",
  "po",
  "target",
}

---@param prefix string
---@param entries string[]
---@return string[]
local function prepend(prefix, entries)
  local arr = {}
  for _, e in ipairs(entries) do
    table.insert(arr, prefix .. e)
  end

  return arr
end

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
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local trouble = require("trouble.providers.telescope")

    telescope.setup({
      defaults = {
        color_devicons = true,
        mappings = {
          i = {
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<A-t>"] = trouble.open_with_trouble,
            ["<A-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
            ["<C-L>"] = actions.add_to_loclist + actions.open_loclist,
            ["<A-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-Q>"] = actions.add_to_qflist + actions.open_qflist,
          },
          n = {
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<A-t>"] = trouble.open_with_trouble,
            ["<A-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
            ["<C-L>"] = actions.add_to_loclist + actions.open_loclist,
            ["<A-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-Q>"] = actions.add_to_qflist + actions.open_qflist,
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
          hidden = true,
        },
        git_files = {
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
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("notify")

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
        glob_pattern = prepend("!", ignore_these),
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

    vim.keymap.set("n", "<leader><leader>", function()
      builtin.find_files({
        find_command = function()
          return {
            "rg",
            "--files",
            "--color",
            "never",
            unpack(prepend("--iglob=!", ignore_these)),
          }
        end
      })
    end, { desc = "Find files" })
  end,
}
