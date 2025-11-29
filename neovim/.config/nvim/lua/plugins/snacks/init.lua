---@module "lazy"
---@module "snacks"

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  opts = function(_, _)
    local in_git_repo = Snacks.git.get_root() ~= nil

    ---@type snacks.Config
    return {
      bigfile = {
        enabled = false,
      },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
          ---@type snacks.dashboard.Item[]
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.picker.smart()",
            },
            { icon = " ", key = "n", desc = "New File", action = ":enew | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.picker.grep({ hidden = true })",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "G",
              desc = "Git",
              action = ":Git",
              enabled = in_git_repo,
            },
            {
              icon = " ",
              key = "b",
              desc = "Checkout Branch",
              action = ":lua Snacks.picker.git_branches()",
              enabled = in_git_repo,
            },
            {
              icon = " ",
              key = "C",
              desc = "CodeCompanion",
              action = ":CodeCompanionChat Toggle",
              enabled = require("lazy.core.config").plugins["codecompanion.nvim"] ~= nil,
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            {
              icon = " ",
              key = "M",
              desc = "Mason",
              action = ":Mason",
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup", padding = 1 },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
        },
      },
      image = {
        enabled = true,
      },
      indent = {
        enabled = false,
        animate = {
          enabled = false,
        },
        chunk = {
          enabled = false,
        },
        indent = {
          enabled = true,
          char = "▏",
        },
        scope = {
          enabled = true,
          char = "▎",
          hl = require("tristan957.utils.list").shuffle({
            "SnacksIndent1",
            "SnacksIndent2",
            "SnacksIndent3",
            "SnacksIndent4",
            "SnacksIndent5",
            "SnacksIndent6",
            "SnacksIndent7",
            "SnacksIndent8",
          }),
        },
      },
      input = {
        enabled = true,
      },
      lazygit = {},
      notifier = {
        enabled = true,
        icons = {
          error = "",
          warn = "",
          info = "",
          debug = "",
          trace = "",
        },
        style = function(buf, notif, ctx)
          if notif.title == nil then
            notif.title = ""
          end

          if notif.icon ~= nil then
            notif.icon = vim.trim(notif.icon) .. " "
          end

          local title = string.format(
            "%s%s%s",
            notif.icon,
            string.len(notif.title) > 0 and " " or "",
            notif.title
          )

          ctx.opts.title = { { " " .. title .. " ", ctx.hl.title } }
          ctx.opts.title_pos = "center"

          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(notif.msg, "\n"))
        end,
      },
      picker = {
        enabled = true,
        previewers = {
          wo = {
            showbreak = "NONE",
          },
        },
        ui_select = true,
      },
      quickfile = {
        enabled = false,
      },
      scroll = {
        enabled = false,
      },
      statuscolumn = {
        enabled = false,
      },
      styles = {
        input = {
          title_pos = "center",
          relative = "editor",
        },
        ---@diagnostic disable-next-line: missing-fields
        notifier = {
          wo = {
            wrap = true,
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        zen = {
          backdrop = {
            transparent = false,
          },
        },
      },
      words = {
        enabled = true,
      },
      zen = {
        toggles = {
          dim = false,
        },
        show = {
          statusline = true,
        },
        win = {},
        zoom = {},
      },
    }
  end,
  config = function(_, opts)
    local Snacks = require("snacks")

    Snacks.setup(opts)

    vim.api.nvim_create_user_command("Lazygit", function()
      Snacks.lazygit.open()
    end, {})

    vim.keymap.set("n", "ZM", Snacks.zen.zen, { desc = "Open buffer in zen mode" })
    vim.keymap.set({ "n", "v" }, "gX", function()
      ---@diagnostic disable-next-line: missing-fields
      Snacks.gitbrowse.open({ what = "permalink" })
    end, { desc = "Open in remote Git host" })

    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        Snacks.notify.info(table.concat(msg, "\n"), {
          id = "lsp_progress",
          title = client.name,
          style = "compact",
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
