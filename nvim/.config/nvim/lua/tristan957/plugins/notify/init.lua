local notify = require("notify")

notify.setup({
	stages = "fade",
	icons = {
		ERROR = "E",
		WARN = "W",
		INFO = "I",
		DEBUG = "D",
		TRACE = "T",
	},
})

vim.notify = notify

require("telescope").load_extension("notify")
