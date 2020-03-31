" Vim graphical configuration.
set macligatures
set guifont=Fira\ Code:h14,Inconsolata:h18,Monaco:h18,Consolas:h12,Lucida_Console:h9
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set guioptions=e
set guioptions-=m
"  set lines=33 columns=100					" Window dimensions.
if exists('+fuoptions')						" Fullscreen options for MacVim.
  set fuoptions=maxvert,maxhorz,background:Normal
endif

" ALE Color Settings
highlight link ALEErrorSign Error
highlight link ALEWarningSign Question
let g:ale_sign_error = '×'
let g:ale_sign_warning = '!'

" Trigger ALE completion w/ CTRL-SPACE
imap <silent> <C-SPACE> <Plug>(ale_complete)
