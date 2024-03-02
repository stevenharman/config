function! s:configureAleForBuffer()
  let l:linters = ['solargraph']
  let l:fixers = []

  if filereadable(ale#ruby#FindProjectRoot(bufnr('')) . '/.rubocop.yml')
    " Found a Rubocop config, use it for linting/fixing
    call add(l:linters, 'rubocop')
    call add(l:fixers, 'rubocop')

    let l:rubocop_bin_path = ale#ruby#FindProjectRoot(bufnr('')) . '/bin/rubocop'
    if filereadable(l:rubocop_bin_path)
      let b:ale_ruby_rubocop_executable = l:rubocop_bin_path
    endif
  else
    " Preferred, and so default, setup is Standard Ruby
    call add(l:linters, 'standardrb')
    call add(l:fixers, 'standardrb')

    let l:standardrb_bin_path = ale#ruby#FindProjectRoot(bufnr('')) . '/bin/standardrb'
    if filereadable(l:standardrb_bin_path)
      let b:ale_ruby_standardrb_executable = l:standardrb_bin_path
    endif
  endif

  " Use Bundler binstub if it exists - this ensures we also scan Git and vendorded Gems
  let l:solargraph_bin_path = ale#ruby#FindProjectRoot(bufnr('')) . '/bin/solargraph'
  if filereadable(l:solargraph_bin_path)
    let b:ale_ruby_solargraph_executable = l:solargraph_bin_path
  endif

  let b:ale_linters = l:linters
  let b:ale_fixers = l:fixers
endfunction

call s:configureAleForBuffer()

" If you have project-specific tools you need to use, you can alter/overwrite
" these by adding something like the following in the project's .git/localvimrc file:
" function! s:configureAleForBufferForProject()
"   let b:ale_linters = ['otherlinter', 'yetanother']
"   let b:ale_fixers = ['otherfixer']
" endfunction
"
" autocmd FileType ruby,eruby call s:configureAleForBufferForProject()
