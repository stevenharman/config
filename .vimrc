" This is Steven Harman's .vimrc file.
" What you'll find here is a mix of ideas I've stolen from others and my own
" preference for how it should be done. Good luck!

" Must come first because it changes other options.
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE FOR MANAGING PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn off for Vundle. Turn it back on below.
filetype plugin off

" Be sure vim-plug is installed:
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
" Setup colorscheme
Plug 'KeitaNakamura/neodark.vim'
let g:neodark#use_custom_terminal_theme = 0 " default: 0
let g:neodark#background = '#202020' " default: '' which is #1F2F38

" original repos on github
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
Plug 'janko-m/vim-test'
Plug 'mileszs/ack.vim'
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case --hidden --glob "!.git/*"'
" 'rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
endif
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Clone fzf to ~/.fzf and run the install script; ignores Brew-installed fzf
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 't9md/vim-ruby-xmpfilter'
let g:xmpfilter_cmd = "seeing_is_believing"
Plug 'sheerun/vim-polyglot'
let g:ruby_indent_assignment_style = 'variable'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-dispatch' " To determine what compiler and errorformat to use for testruns/Quickfix
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
" Use gem-ctags to generate CTags for all gems in the Bundle
let g:rails_ctags_arguments = '--exclude=tmp'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" vim-scripts repos
Plug 'emnh/taglist.vim' " The vim-scripts/taglist.vim seems no longer maintained; trying a fork with updated version (4.6) See: https://github.com/vim-scripts/taglist.vim/pull/7#issuecomment-26350720
" non github repos

call plug#end() " plug#end() Automatically executes `filetype plugin indent on` and `syntax enable`

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow unsaved background buffers and remember marks/undo for them
set hidden
" Remember more commands and search history
set history=10000
" Tab defaults
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
"set foldmethod=syntax
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`, `?`, and `!`.
set nojoinspaces
set showmatch
set incsearch
set hlsearch
" Case-insensitive searching
set ignorecase
" Unless expression contains a capital letter.
set smartcase
set mouse=a
set ruler
set number
" Highlight current line and column
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * set cursorline cursorcolumn
set title
set switchbuf=useopen
set winwidth=79
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=
" Show 3 lines of context around the cursor.
set scrolloff=3
set nobackup
set nowritebackup
"set backupdir=./tmp,$HOME/.vim/tmp/,$TEMP/,.
"set directory=./tmp,$HOME/.vim/tmp/,$TEMP/,.
set tags^=./.git/tags;
" Intuitive backspacing in insert mode.
set backspace=indent,eol,start
" custom whitespace characters
set listchars=tab:▸\ ,eol:¬,trail:⦿,extends:>,precedes:<
" Display incomplete commands.
set showcmd
" sane split directions
set splitright
set splitbelow
" Set to auto read when a file is changed from the outside
set autoread
" No beeping.
set visualbell

" Spell checking, including automagically for git & markdown
set spellfile=$HOME/.vim/spell/en.utf-8.add
autocmd FileType gitcommit,markdown setlocal spell
autocmd FileType gitcommit,markdown setlocal complete+=kspell

set wildmode=list:longest
set wildignore+=tmp,bower_components,dist,node_modules
" make tab completion for files/buffers act like bash
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber setlocal autoindent sw=2 sts=2 expandtab
  autocmd FileType ruby,eruby setlocal complete-=i
  autocmd FileType python setlocal sw=4 sts=4 expandtab
  autocmd FileType go setlocal noexpandtab
  autocmd FileType vue call RagtagInit()

  " When editing Vim config, automagically reload!
  autocmd! BufWritePost {.vimrc,.gvimrc} source %
augroup END

augroup vimrc
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

augroup filetypedetect
  au! BufRead,BufNewFile *.inky set filetype=eruby.html
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" let the terminal determine the colors to use
set background=dark
if has("gui_running") || &t_Co >= 256
  " let g:rehash256=1 " only used for Molokai color scheme
  :color neodark
else
  set t_Co=16     " every terminal I use supports at least 16, right?
  :color solarized  " a 16-color safe theme
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=[%n]     "current buffer number
set statusline+=\ %f    "tail of the filename

"display a warning if fileformat isn't Unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isn't utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=\ %h    "help file flag
set statusline+=%w      "preview
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
set statusline+=\ %{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

"display a warning if we have trailing white space
set statusline+=%#error#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=\ %{LinterStatus()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        " Show the status line all the time
"hi CursorLine cterm=none ctermbg=black

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
  let name = synIDattr(synID(line('.'),col('.'),1),'name')
  if name == ''
    return ''
  else
    return '[' . name . ']'
  endif
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '[%dW %dE]',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

function! FileEncodingAndBomb()
  let enc = (&fenc=="" ? &enc : &fenc)
  let bomb = ((exists("+bomb")) && &bomb) ? ",B" : ""
  return '['.enc.bomb.']'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAKE ALL PARENT DIRECTORIES FOR A FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MkNonExDirP(file)
  if a:file!~#'\v^\w+\:\/' " don't write files like ftp://*
    let new_dir = fnamemodify(a:file, ':h')
    if !isdirectory(new_dir)
      call mkdir(new_dir, 'p')
      redraw!
    endif
  endif
endfunction
map <leader>mk :call MkNonExDirP(expand('%'))<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    call MkNonExDirP(new_name)
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>mv :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN CURRENT FILE IN MARKED.APP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MarkedPreview()
  :w
  let s:markedApp = "/usr/bin/open -a 'Marked 2.app'"
  let s:currentFile = expand("%")
  let s:cmd = "silent ! " . s:markedApp . " " . s:currentFile
  execute s:cmd
  redraw!
endfunction
map <leader>md :call MarkedPreview()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCH FOR THE WORD UNDER THE CURSOR USING Dash.app
" see: https://gist.github.com/Kapeli/5017177
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction
map <leader>d :call SearchDash()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RESTART RAILS SERVER (when vim-rails detectes Rails)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RestartRails()
  if RailsDetect()
    execute "AsyncRun touch <root>/tmp/restart.txt"
  endif
endfunction
map <leader>R :call RestartRails()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC FZF TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:javascript_dir = isdirectory('app/javascript') ? 'app/javascript' : 'app/assets/javascripts'
let s:styles_dir = isdirectory('app/javascript/stylesheets') ? 'app/javascript/stylesheets' : 'app/assets/stylesheets'

" add a :Find command using ripgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>
map <leader>ga :Files app<cr>
map <leader>gc :Files app/controllers<cr>
map <leader>gh :Files app/helpers<cr>
map <leader>gm :Files app/models<cr>
map <leader>gv :Files app/views<cr>
execute 'map <leader>gj :Files ' . s:javascript_dir . '<cr>'
execute 'map <leader>gs :Files ' . s:styles_dir . '<cr>'
map <leader>gS :Files spec<cr>
map <leader>gl :Files lib<cr>
map <leader>gp :Files public<cr>
" Tags in the project
nnoremap <leader>gt :Tags<cr>
" Tags in the current buffer
nnoremap <leader>gT :BTags<cr>
nnoremap <leader>f :Files<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = {
  \ 'nearest': 'basic',
  \ 'file':    'asyncrun',
  \ 'suite':   'asyncrun',
\}
nmap <silent> <leader>t :TestFile<cr>
nmap <silent> <leader>T :TestNearest<cr>
nmap <silent> <leader>a :TestSuite<cr>
nmap <silent> <leader>A :TestSuite -strategy=basic<cr>
nmap <silent> <leader>N :TestSuite --next-failure<cr>
nmap <silent> <leader>L :TestLast<cr>
nmap <silent> <leader>v :TestVisit<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XMPFilter or Seeing Is Believing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert ' # =>' into end of line or delete ' # =>' if it already exist.
autocmd FileType ruby nmap <buffer> <F6> <Plug>(seeing_is_believing-mark)
autocmd FileType ruby xmap <buffer> <F6> <Plug>(seeing_is_believing-mark)
autocmd FileType ruby imap <buffer> <F6> <Plug>(seeing_is_believing-mark)
" Clean all marks in the buffer.
autocmd FileType ruby nmap <buffer> <S-F6> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby xmap <buffer> <S-F6> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby imap <buffer> <S-F6> <Plug>(seeing_is_believing-clean)
" Insert evaluated result with mark.
autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby xmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing_is_believing-run)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-ALE Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_list_window_size = 5 " default = 10
let g:ale_lint_delay = 300 " default = 200ms
" MacVim/GUI setting in .gvimrc
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_set_highlights = 0
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_linters = {
      \ 'go': ['gofmt', 'golint', 'gopls', 'govet'],
      \ 'ruby': ['solargraph', 'standardrb']
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'go': ['gofmt', 'goimports'],
      \ 'ruby': ['standardrb']
      \}

" Fix style, lint, etc... via ALE Fixers
nmap <leader>F <Plug>(ale_fix)
nmap gJ <Plug>(ale_next_wrap)
nmap gK <Plug>(ale_previous_wrap)
nmap g1 <Plug>(ale_first)
nmap gd <Plug>(ale_go_to_definition)
nmap gr <Plug>(ale_find_references)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  if pumvisible()
    " we're already in completion mode, select the next item down the list
    return "\<C-n>"
  endif

  let col = col('.') - 1
  if !col
    " at the beignning of the line, do a normal tab
    return "\<tab>"
  endif

  let char = getline('.')[col - 1]
  if char =~ '\k'
    " There's an identifier before the cursor, so complete the identifier.
    " NOTE: We coud triger AlE's completion here with the following:
    "    return "\<C-\>\<C-O>\:ALEComplete\<CR>"
    return "\<c-p>"
  else
    return "\<tab>"
  endif
endfunction

inoremap <silent><expr> <TAB> InsertTabWrapper()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Trigger ALE completion w/ CTRL-SPACE (@ needed for terminal Vim)
imap <silent> <C-@> <Plug>(ale_complete)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAPPINS... THE REST OF THEM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Seriously, it's not like :W is bound to anything anyway.
command! W :w

" redo with U
nmap U :redo<cr>

" easy wrap toggling
nmap <leader>w :set wrap<cr>
nmap <leader>W :set nowrap<cr>

" move around splits with ctrl+movement
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" resize the window by 5 lines/columns
nnoremap <S-left> :vertical resize -5<cr>
nnoremap <S-down> :resize -5<cr>
nnoremap <S-up> :resize +5<cr>
nnoremap <S-right> :vertical resize +5<cr>

" swap windows
nmap gS <C-W><C-R>

" close all other windows (in the current tab)
nmap gW :only<cr>

" Reopen the last buffer in the current window
nnoremap <leader><leader> <c-^>

" NERDTree
map <leader>n :NERDTreeToggle<cr>
map gs :NERDTreeFind<cr>

" ack for project-wide searching
nmap g/ :Ack!<space>
nmap g* :Ack! -w <C-R><C-W>
nmap gA :AckAdd!
nmap gj :cnext<cr>
nmap gk :cprev<cr>
nmap gc :call asyncrun#quickfix_toggle(8)<cr>

" search and replace the word under the cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>/
" remove search highlighting
nmap <silent> <leader>h :silent :nohlsearch<CR>

" Re-draw syntax highlighting
nmap <silent> <leader>H :syntax sync fromstart<CR>

" rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" clear up trailing white space
nmap <leader>s :%s/\s\+$//<CR>

" insert blank lines without going into insert mode
nmap go o<esc>
nmap gO O<esc>

" Bubble single lines (uses unimpaired.vim)
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" scroll up/down one line at a time
nmap <Up> <C-Y>
nmap <Down> <C-E>
" scroll up/down 3 lines at a time
nnoremap <C-Y> 3<C-Y>
nnoremap <C-E> 3<C-E>

" scroll left/right
nmap <Left> zh
nmap <Right> zl


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER MACROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

