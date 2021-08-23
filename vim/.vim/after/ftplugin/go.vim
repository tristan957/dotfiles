augroup mygo
	autocmd!
	if has('nvim-0.5')
		"autocmd BufWritePre * set background=light
		autocmd BufWritePre :silent! :Gofmt
	else
		autocmd BufWritePre :silent! GoImports
	endif
augroup END
