vim.filetype.add({
  extension = {
    ---@param path string
    h = function(path)
      -- Try to be a little intelligent when determining if a .h file is C++ or C

      -- If a .cc or .cpp file with the same basename exists next to this
      -- header file, assume the header is C++.
      local stem = vim.fn.fnamemodify(path, ":r")
      if
        vim.uv.fs_stat(string.format("%s.cc", stem))
        or vim.uv.fs_stat(string.format("%s.cpp", stem))
      then
        return "cpp"
      end

      -- If the header file contains C++ specific keywords, assume it is
      -- C++
      if
        vim.fn.search(
          string.format(
            [[\C\%%(%s\)]],
            table.concat({
              [[^#include <[^>.]\+>$]],
              [[\<constexpr\>]],
              [[\<consteval\>]],
              [[\<extern "C"\>]],
              [[^class\> [A-Z]],
              [[^\s*using\>]],
              [[\<template\>\s*<]],
              [[\<std::]],
            }, "\\|")
          ),
          "nw"
        ) ~= 0
      then
        return "cpp"
      end

      return "c"
    end,
    out = "output",
    plist = "xml",
  },
  filename = {
    [".clang-format"] = "yaml",
    [".clang-tidy"] = "yaml",
    [".envrc"] = "sh",
    [".vscode/extensions.json"] = "jsonc",
    [".vscode/settings.json"] = "jsonc",
    [".vscode/tasks.json"] = "jsonc",
    ["devcontainer.json"] = "jsonc",
    ["hse.conf"] = "json",
    ["kvdb.conf"] = "json",
    ["kvdb.meta"] = "json",
    ["kvdb.pid"] = "json",
  },
  pattern = {
    [".*config/aerc/accounts.conf"] = "ini",
    [".*config/aerc/aerc.conf"] = "ini",
    [".*config/aerc/templates/.*"] = "aerc-template",
    [".*config/git/.*.config"] = "gitconfig",
    [".*config/hut/config"] = "scfg",
  },
})
