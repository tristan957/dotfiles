vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    if value.kind == "begin" then
      io.stdout:write("\027]9;4;1;0\027\\")
    elseif value.kind == "end" then
      io.stdout:write("\027]9;4;0\027\\")
    elseif value.kind == "report" then
      io.stdout:write(string.format("\027]9;4;1;%d\027\\", value.percentage or 0))
    end
  end,
})
