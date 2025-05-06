local M = {}

--- Get the current system color-scheme
---
--- https://flatpak.github.io/xdg-desktop-portal/docs/doc-org.freedesktop.portal.Settings.html
---
---@return "dark" | "light"
M.color_scheme = function()
  local cmd = vim
    .system({
      "busctl",
      "--user",
      "-j",
      "call",
      "org.freedesktop.portal.Desktop",
      "/org/freedesktop/portal/desktop",
      "org.freedesktop.portal.Settings",
      "ReadOne",
      "ss",
      "org.freedesktop.appearance",
      "color-scheme",
    }, { text = true })
    :wait()

  if cmd.code ~= 0 then
    return "light"
  end

  return vim.json.decode(cmd.stdout)["data"][1]["data"] == 1 and "dark" or "light"
end

return M
