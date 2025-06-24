---@module "lazy"
---@module "markview"

---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  enabled = true,
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "Saghen/blink.cmp",
  },
  ---@param _ LazyPlugin
  ---@param opts markview.config
  opts = function(_, opts)
    local filetypes = { "markdown" }
    if vim.tbl_get(opts, "preview", "filetypes") ~= nil then
      filetypes = vim.list_extend(filetypes, opts.preview.filetypes)
    end

    ---@type markview.config
    return vim.tbl_deep_extend("keep", {
      preview = {
        filetypes = filetypes,
        callbacks = {
          on_attach = function(_, wins)
            for win in ipairs(wins) do
              vim.wo[win].list = false
            end
          end,
          on_detach = function(_, wins)
            for win in ipairs(wins) do
              vim.wo[win].list = true
            end
          end,
          on_mode_change = function(_, wins, mode)
            local list = mode == "i"
            for win in ipairs(wins) do
              vim.wo[win].list = list
            end
          end,
        },
        ignore_buftypes = {},
      },
    }, opts)
  end,
}
