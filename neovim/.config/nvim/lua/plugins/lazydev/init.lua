---@module "lazy"
---@module "lazydev"

---@type LazySpec[]
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    ---@type lazydev.Config
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      enabled = function(root_dir)
        for _, file in ipairs({ ".luarc.json", ".luarc.jsonc" }) do
          if vim.uv.fs_stat(vim.fs.joinpath(root_dir, file)) then
            return false
          end
        end

        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
}