local lsp_status = require("lsp-status")

lsp_status.config({
  indicator_errors = "E",
  indicator_warnings = "W",
  indicator_info = "I",
  indicator_hint = "?",
  indicator_ok = "ok",
  status_symbol = "",
})

lsp_status.register_progress()
