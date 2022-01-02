vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	float = { border = "single" },
})

vim.cmd([[au CursorHold * lua vim.diagnostic.open_float(0,{scope = "cursor"})]])
