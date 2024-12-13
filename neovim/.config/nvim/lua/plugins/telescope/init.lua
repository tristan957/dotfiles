---@module "lazy"

---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  dependencies = {
    "echasnovski/mini.icons",
    "folke/trouble.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fs = require("tristan957.utils.fs")

    local open_with_trouble = require("trouble.sources.telescope").open

    telescope.setup({
      defaults = {
        color_devicons = true,
        mappings = {
          i = {
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,
            ["<C-t>"] = open_with_trouble,
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
            ["<C-t>"] = open_with_trouble,
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
          follow = true,
          hidden = true,
          find_command = function(opts)
            local cmd = { "rg", "--files", "--color=never" }

            if opts.hidden then
              cmd[#cmd + 1] = "--hidden"
            end

            if opts.follow then
              cmd[#cmd + 1] = "--follow"
            end

            vim.list_extend(
              cmd,
              vim
                .iter(fs.largely_irrelevant_paths)
                :map(function(p)
                  return string.format("--glob=!%s", p)
                end)
                :totable()
            )

            return cmd
          end,
        },
        git_files = {},
        live_grep = {
          additional_args = { "--hidden" },
          glob_pattern = vim
            .iter(fs.largely_irrelevant_paths)
            :map(function(p)
              return string.format("!%s", p)
            end)
            :totable(),
        },
        map_pages = {
          sections = { "ALL" },
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
  end,
}
