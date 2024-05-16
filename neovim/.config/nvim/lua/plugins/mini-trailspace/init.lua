---@type LazySpec
return {
  "echasnovski/mini.trailspace",
  event = { "BufRead", "BufNewFile" },
  config = function()
    local MiniTrailspace = require("mini.trailspace")

    MiniTrailspace.setup()

    local group = vim.api.nvim_create_augroup("tristan957_MiniTrailspace", { clear = true })
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
      desc = "Stop highlighting trailing white space",
      group = group,
      callback = function(ev)
        if not vim.bo[ev.buf].modifiable then
          MiniTrailspace.unhighlight()
          return
        end

        if vim.b[ev.buf].minitrailspace_disable then
          MiniTrailspace.unhighlight()
          return
        end

        -- We should unhighlight in the case where we have allowed trailing
        -- whitespace
        local should_disable = string.find(vim.bo[ev.buf].formatoptions, "w") ~= nil
        vim.b[ev.buf].minitrailspace_disable = should_disable
        if should_disable then
          MiniTrailspace.unhighlight()
        end
      end,
    })
  end,
}
