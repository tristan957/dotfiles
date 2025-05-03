---@module "lazy"

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "OXY2DEV/markview.nvim",
      opts = {
        preview = {
          filetypes = { "codecompanion" },
        },
      },
    },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  keys = {
    { "<C-`>", "<cmd>CodeCompanionActions<cr>", { "n", "v" }, noremap = true, silent = true },
    {
      "<Leader>`",
      "<cmd>CodeCompanionChat Toggle<cr>",
      { "n", "v" },
      noremap = true,
      silent = true,
    },
    { "g`", "<cmd>CodeCompanionChat Add<cr>", "v", noremap = true, silent = true },
  },
  opts = function(_, _)
    local utils = require("tristan957.utils")

    return {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = utils.rstrip(vim
                .system({
                  "op",
                  "--account",
                  "my.1password.com",
                  "read",
                  "op://Personal/j3bxrfsofvsfhxggdfwdlhiqhy/credential",
                })
                :wait().stdout),
            },
          })
        end,
      },
      chat = {
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using Telescope",
            opts = {
              provider = "snacks",
              contains_code = true,
            },
          },
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          follow = true,
          icons = {
            pinned_buffer = " ",
            watched_buffer = " ",
          },
          window = {
            layout = "vertical",
            position = nil,
            relative = "editor",
            width = 0.5,
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
        },
        inline = {
          layout = "vertical",
        },
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
      opts = {
        log_level = "TRACE",
      },
      strategies = {
        chat = {
          adapter = "anthropic",
          keymaps = {
            send = {
              modes = { n = "<CR>", i = "<C-s>" },
            },
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
            },
          },
        },
        inline = {
          adapter = "anthropic",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
      },
    }
  end,
}
