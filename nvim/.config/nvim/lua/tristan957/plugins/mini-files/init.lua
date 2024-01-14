---@type LazySpec
return {
  "echasnovski/mini.files",
  event = "BufEnter",
  config = function()
    local MiniFiles = require("mini.files")

    MiniFiles.setup({
      use_as_default_explorer = true,
    })

    local toggle = function()
      if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end
    end

    vim.keymap.set("n", "<leader>n", toggle, { silent = true })

    local map_split = function(buf_id, lhs, close_on_file, direction)
      local rhs = function()
        local new_target_window
        local old_target_window = MiniFiles.get_target_window()
        assert(old_target_window ~= nil)
        vim.api.nvim_win_call(old_target_window, function()
          vim.cmd(direction .. " split")
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in({ close_on_file = close_on_file })
      end

      local desc = "Split " .. direction
      if close_on_file then
        desc = desc .. " plus"
      end

      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end

    local group = vim.api.nvim_create_augroup("tristan957/mini-files", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        map_split(buf_id, "gs", false, "belowright horizontal")
        map_split(buf_id, "gS", true, "belowright horizontal")
        map_split(buf_id, "gv", false, "belowright vertical")
        map_split(buf_id, "gV", true, "belowright vertical")
      end,
    })
  end
}
