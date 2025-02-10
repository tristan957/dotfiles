---@module "lazy"

---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = false,
    },
    dashboard = {
      enabled = false,
    },
    gitbrowse = {
      url_patterns = {
        ["git.sr.ht"] = {
          branch = "/tree/{branch}",
          file = "/tree/{branch}/item/{file}",
          permalink = "/tree/{commit}/item/{file}#L{line_start}",
          commit = "/commit/{commit}",
        },
      },
    },
    indent = {
      enabled = false,
    },
    input = {
      enabled = true,
    },
    lazygit = {},
    notifier = {
      enabled = true,
      style = "fancy",
    },
    picker = {
      enabled = true,
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
        border = "rounded",
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
      enabled = false,
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
    }
  },
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
