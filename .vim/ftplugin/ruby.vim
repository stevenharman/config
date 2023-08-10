let b:ale_linters = ['solargraph', 'standardrb']
let b:ale_fixers = ['standardrb']

" Override these defaults by adding custom linters/fixers on a per-project
" basis by adding something like the following in the project's
" .git/localvimrc file:
" function! ConfigureAleForBuffer()
"   let b:ale_linters = ['solargraph', 'rubocop']
"   let b:ale_fixers = ['rubocop']
"   # If we have Rubocop in our Gemfile, we want to `bundle exec` it.
"   let b:ale_ruby_rubocop_executable = 'bundle'
" endfunction
"
" autocmd FileType ruby,eruby call ConfigureAleForBuffer()
