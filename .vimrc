" Basic Vim Config

set nocompatible                  " Must come first because it changes other options.

silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set showmatch                     " Show matching parens
"set complete=.,t                  " Only use current file and ctags for complete
set completeopt=longest,menuone		" Use longest text of all matches, even if only one match

set backspace=indent,eol,start    " Intuitive backspacing in insert mode.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set mouse=a                       " Have the mouse enabled all the time.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set cursorline                    " highlight current line
"hi CursorLine cterm=none ctermbg=black

set number                        " Show line numbers.
set ruler                         " Show cursor position.
" custom whitespace characters
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<

set autoread                      " Set to auto read when a file is changed from the outside

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set gdefault                      " assume the /g flag on :s substitutions to replace all matches in a line:

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

"let g:syntastic_enable_signs=1    "mark syntax errors with :signs

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp/,$TEMP/,.  " Keep swap files in one location

" Tabs or spaces? Spaces!
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " how many columns are indented with reindent operations
set softtabstop=2                " how many columns to use when you hit 'tab' (generally keep equal to shiftwidth)
set expandtab                    " Use spaces instead of tabs
set autoindent

" sane split directions
set splitright
set splitbelow

" a more useful statusline
function! FileEncodingAndBomb()
  let enc = (&fenc=="" ? &enc : &fenc)
  let bomb = ((exists("+bomb")) && &bomb) ? ",B" : ""
  return '['.enc.bomb.']'
endfunction

set laststatus=2                  " Show the status line all the time
set statusline=[%n]\ %<%.99f\ %{FileEncodingAndBomb()}\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" tired of shitty colors in old terminals. 
:set t_Co=256 " 256 colors
:color molokai

" Automatic fold settings for specific files. Uncomment to use.
" autocmd FileType ruby setlocal foldmethod=syntax
" autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! ShowColors()
  let num = 255
  while num >= 0
    exec 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
    exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
    call append(0, 'ctermbg='.num.':....')
    let num = num - 1
  endwhile
endfunction

" do autocompletion or indentation depending on the context
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Running tests
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-makegreen binds itself to ,t unless something else is bound to its
" function.
map <leader>\dontstealmymapsmakegreen :w\|:call MakeGreen('spec')<cr>

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!script/tests " . a:filename
    " script/tests is a custom script based on https://gist.github.com/888666
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile()
    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>a :call RunTests('spec')<cr>

let g:localvimrc_ask = 0 " Don't ask before sourcing local vimrc files
let g:localvimrc_sandbox = 0 " Don't source the found local vimrc files in a sandbox

runtime key_mappings.vim
