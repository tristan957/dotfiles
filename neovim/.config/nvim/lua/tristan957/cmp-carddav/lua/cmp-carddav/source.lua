local carddav_source = {}

---@param opts cmp_carddav.Options
carddav_source.new = function(opts)
  return setmetatable({}, { __index = carddav_source, opts = opts })
end

function carddav_source:is_available()
  return vim.fn.executable("carddav-query") == 1
end

function carddav_source:get_debug_name()
  return table.concat({ "carddav" }, "/")
end

function carddav_source:get_trigger_characters()
  return { "~" }
end

-- function carddav_source:get_keyword_pattern()
--   return [[\%]]
-- end

---@param self cmp.Source
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function carddav_source:complete(params, callback)
  local cmd = vim.system({ "carddav-query", "-S", "Personal", "" }):wait()
  if cmd.code ~= 0 then
    callback()
    return
  end

  callback(vim.iter(vim.split(cmd.stdout, "\n", { trimempty = true })):map(function(e)
    local components = vim.split(e, "\t")
    local email = components[1]
    local name = nil
    if #components > 1 then
      name = components[2]
    end

    local label = email
    local insertText = "<" .. email .. ">"
    if name ~= nil then
      label = name .. " " .. email
      insertText = '"' .. name .. '"' .. " " .. label
    end

    ---@type lsp.CompletionItem
    return {
      label = label,
      insertText = insertText,
    }
  end):totable())
end

return carddav_source
