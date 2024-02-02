let b:ale_linters = ['solargraph', 'standardrb']
let b:ale_fixers = ['standardrb']

" Use Bundler binstub if it exists - this ensures we also scan Git and vendorded Gems
let b:solargraph_bin_path = ale#ruby#FindProjectRoot(bufnr('')) . '/bin/solargraph'
if filereadable(b:solargraph_bin_path)
  let b:ale_ruby_solargraph_executable = b:solargraph_bin_path
endif

" Override these defaults by adding custom linters/fixers on a per-project
" basis by adding something like the following in the project's .git/localvimrc file:
" Keep in sync with https://gist.github.com/stevenharman/7115e1344a3b95f5795cdba1b44ca3d2

" function! ConfigureAleForBuffer()
"   let b:ale_linters = ['solargraph', 'rubocop']
"   let b:ale_fixers = ['rubocop']
"   " If we have Rubocop in our Gemfile, we want to `bundle exec` it.
"   let b:ale_ruby_rubocop_executable = 'bundle'
"   " ale_ruby_solargraph_executable is set in https://github.com/stevenharman/config/blob/main/.vim/ftplugin/ruby.vim
" endfunction
"
" autocmd FileType ruby,eruby call ConfigureAleForBuffer()
