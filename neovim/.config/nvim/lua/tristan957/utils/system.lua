local M = {}

--- Get the current system color-scheme
---
--- On Linux:
--- https://flatpak.github.io/xdg-desktop-portal/docs/doc-org.freedesktop.portal.Settings.html
---
--- If the command to retrieve the theme fails, the return value will be dark.
---
---@return "dark" | "light"
M.color_scheme = function()
  if vim.uv.os_uname().sysname == "Darwin" then
    local utils = require("tristan957.utils")

    local cmd = vim.system({"defaults", "read", "-g", "AppleInterfaceStyle"}):wait()

    if cmd.code ~= 0 then
      return "light"
    end

    return utils.rstrip(cmd.stdout) == "Dark" and "dark" or "light"
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
    return "dark"
  end

  return vim.json.decode(cmd.stdout)["data"][1]["data"] == 1 and "dark" or "light"
end

--- Check if this is an arca machine
---
--- arca is a Databricks thing.
---
---@return boolean
M.is_arca = function()
  return vim.fn.filereadable(vim.fs.joinpath(vim.env.HOME, ".arca", "last_arch")) == 1
end

return M
