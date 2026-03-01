---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  cond = not require("tristan957.utils.system").is_arca(),
  dependencies = {
    "github/copilot.vim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "OXY2DEV/markview.nvim",
      ---@return markview.config | {}
      opts = function()
        ---Conceal HTML tags
        ---@param icon string
        ---@param hl_group string
        ---@return markview.config.html.container_elements.opts
        local function conceal_tag(icon, hl_group)
          return {
            on_node = { hl_group = hl_group },
            on_closing_tag = { conceal = "" },
            on_opening_tag = {
              conceal = "",
              virt_text_pos = "inline",
              virt_text = { { icon .. " ", hl_group } },
            },
          }
        end

        ---@type markview.config | {}
        return {
          ---@type markview.config.html | {}
          html = {
            enable = true,
            container_elements = {
              enable = true,
              ["^buf$"] = conceal_tag("", "CodeCompanionChatVariable"),
              ["^file$"] = conceal_tag("", "CodeCompanionChatVariable"),
              ["^help$"] = conceal_tag("󰘥", "CodeCompanionChatVariable"),
              ["^image$"] = conceal_tag("", "CodeCompanionChatVariable"),
              ["^symbols$"] = conceal_tag("", "CodeCompanionChatVariable"),
              ["^url$"] = conceal_tag("󰖟", "CodeCompanionChatVariable"),
              ["^var$"] = conceal_tag("", "CodeCompanionChatVariable"),
              ["^tool$"] = conceal_tag("", "CodeCompanionChatTool"),
              ["^user_prompt$"] = conceal_tag("", "CodeCompanionChatTool"),
              ["^group$"] = conceal_tag("", "CodeCompanionChatToolGroup"),
            },
          },
          preview = {
            filetypes = { "codecompanion" },
          },
        }
      end,
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
    return {
      adapters = {
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = vim
                  .system({
                    "op",
                    "--account",
                    "my.1password.com",
                    "read",
                    "--no-newline",
                    "op://Personal/j3bxrfsofvsfhxggdfwdlhiqhy/credential",
                  })
                  :wait().stdout,
              },
            })
          end,
        },
      },
      chat = {
        slash_commands = {
          ["file"] = {
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using picker",
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
          auto_scroll = true,
          follow = true,
          icons = {
            buffer_pin = " ",
            buffer_watch = " ",
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
      interactions = {
        chat = {
          opts = {
            completion_provider = "blink",
          },
        },
      },
      opts = {
        log_level = "ERROR",
      },
      strategies = {
        chat = {
          adapter = "copilot",
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
          adapter = "copilot",
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
