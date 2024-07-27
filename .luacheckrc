---@diagnostic disable:lowercase-global

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
  "122", -- Setting a read-only field of a global variable
  "212", -- Unused argument
}

read_globals = {
  "vim",
}
