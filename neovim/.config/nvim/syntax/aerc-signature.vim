if exists("b:current_syntax")
  finish
endif

" Load the mail syntax
runtime! syntax/mail.vim

" Set the current syntax name
let b:current_syntax = "aerc-signature"
