" Textmate Fuzzy Finder options
  let g:FuzzyFinderOptions = { 'Base':{} }
  let g:FuzzyFinderOptions.Base.key_open_tab = '<D-CR>'
  let g:FuzzyFinderOptions.Base.key_open_split = '<S-CR>'
  let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;doc/**;vendor/**;coverage/**;tmp/**"
  let g:fuzzy_matching_limit = 20

" Markdown syntax highlighting
  augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:>
    autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:>
  augroup END
