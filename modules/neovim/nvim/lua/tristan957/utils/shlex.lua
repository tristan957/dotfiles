local M = {}

---Split a string into arguments, respecting quotes and escapes (shlex.split equivalent)
---@param s string
---@return string[]
function M.split(s)
  local args = {}

  local i = 1
  while i <= #s do
    if s:sub(i, i):match("%s") then
      i = i + 1
    elseif s:sub(i, i) == '"' or s:sub(i, i) == "'" then
      local quote = s:sub(i, i)

      i = i + 1
      local arg = ""
      while i <= #s and s:sub(i, i) ~= quote do
        if s:sub(i, i) == "\\" and i + 1 <= #s then
          arg = arg .. s:sub(i + 1, i + 1)
          i = i + 2
        else
          arg = arg .. s:sub(i, i)
          i = i + 1
        end
      end

      if i <= #s then
        i = i + 1
      end

      table.insert(args, arg)
    else
      local arg = ""
      while i <= #s and not s:sub(i, i):match("%s") do
        if s:sub(i, i) == "\\" and i + 1 <= #s then
          arg = arg .. s:sub(i + 1, i + 1)
          i = i + 2
        else
          arg = arg .. s:sub(i, i)
          i = i + 1
        end
      end

      table.insert(args, arg)
    end
  end

  return args
end

return M
