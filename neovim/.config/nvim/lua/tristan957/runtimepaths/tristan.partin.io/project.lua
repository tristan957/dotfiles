local group = vim.api.nvim_create_augroup("tristan957_project", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  desc = "Format files with Prettier",
  pattern = { "*.md", "*.yaml", "*.yml" },
  callback = function(ev)
    local prettier = "prettier"

    if vim.fn.executable(prettier) ~= 1 then
      -- Check if it is install in node_modules
      -- TODO: is it possible to get yarn or npm to tell me the path of prettier?
      prettier = "node_modules/.bin/prettier"
      if vim.fn.executable(prettier) ~= 1 then
        return
      end
    end

    local cmd = vim
      .system({
        prettier,
        "--config",
        ".prettierrc.yml",
        "--write",
        vim.api.nvim_buf_get_name(ev.buf),
      })
      :wait()
    if cmd.code == 0 then
      vim.cmd.edit()
      return
    end

    vim.notify("Failed to run prettier (" .. cmd.code .. "): " .. cmd.stderr, vim.log.levels.ERROR)
  end,
})
