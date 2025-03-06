local M = {}

--- Get the current system color-scheme
---
--- https://flatpak.github.io/xdg-desktop-portal/docs/doc-org.freedesktop.portal.Settings.html
---
--- On Neovim 0.11, vim.o.background is kept in sync by Neovim itself.
---
---@return "dark" | "light"
M.color_scheme = function()
  if vim.fn.has("nvim-0.11") then
    return vim.o.background
  end

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
