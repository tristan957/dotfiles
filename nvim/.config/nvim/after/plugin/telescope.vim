nnoremap <leader><S-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>p <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader><S-f> <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
