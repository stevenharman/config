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

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" manage Vundle with Vundle. BOOM!
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'Raimondi/delimitMate'
Bundle 'airblade/vim-gitgutter'
Bundle 'groenewege/vim-less'
Bundle 'juvenn/mustache.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mileszs/ack.vim'
Bundle 'othree/html5.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
let g:rails_ctags_arguments = '--languages=-javascript --exclude=tmp'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
" vim-scripts repos
Bundle 'taglist.vim'
Bundle 'VimClojure'
" non github repos

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
" Tabs or spaces? Spaces!
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
"set foldmethod=syntax
set nofoldenable
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
" highlight current line
set cursorline
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
set tags^=./tmp/tags
" Intuitive backspacing in insert mode.
set backspace=indent,eol,start
" custom whitespace characters
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<
" Display incomplete commands.
set showcmd
" sane split directions
set splitright
set splitbelow
" Set to auto read when a file is changed from the outside
set autoread
" No beeping.
set visualbell

syntax enable

filetype plugin indent on
set wildmode=list:longest
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
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  "autocmd! BufRead,BufNewFile *.sass setfiletype sass
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let the terminal determine the colors to use
set background=dark
if has("gui_running") || &t_Co >= 256
  :color molokai
else
  set t_Co=16     " every terminal I use supports at least 16, right?
  :color solarized  " a 16-color safe theme
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=[%n]     "current buffer number
set statusline+=\ %f    "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=\ %h      "help file flag
set statusline+=%w      "preview
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
"set statusline+=%{rvm#statusline()}
set statusline+=\ %{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%#error#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%*

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

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
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
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
  let s:markedApp = "/usr/bin/open -a Marked.app"
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
" MAPS TO JUMP TO SPECIFIC COMMAND-T TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
map <leader>gg :topleft :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>gi :CommandTFlush<cr>\|:CommandT integration_spec<cr>
let g:CommandTCursorStartMap='<leader>f'
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  if match(a:filename, '\(_spec.rb\|spec$\)') != -1
    call RunRspecTests(a:filename)
  elseif match(a:filename, '\.feature$') != -1
    exec ":!script/features " . a:filename
  elseif match(a:filename, '_test.rb') != -1
    exec ":!bundle exec ruby -Itest " . a:filename
  endif
endfunction

function! RunRspecTests(spec_file)
  if filereadable("script/test")
    exec ":!script/test " . a:spec_file
  elseif filereadable("Gemfile")
    exec ":!bundle exec rspec --color " . a:spec_file
  else
    exec ":!rspec --color " . a:spec_file
  end
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:smh_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1

  if in_test_file
    call SetTestFile()
  elseif !exists("t:smh_test_file")
    return
  end
  call RunTests(t:smh_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('spec')<cr>
map <leader>A :call RunTests('')<cr>

"let g:vroom_map_keys = 0
"map <unique> <Leader>t :VroomRunTestFile<CR>
"map <unique> <Leader>T :VroomRunNearestTest<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAPPINS... THE REST OF THEM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Seriously, it's not like :W is bound to anything anyway.
command! W :w

" redo with U
nmap U :redo<cr>

" easy wrap toggling
nmap <Leader>w :set wrap<cr>
nmap <Leader>W :set nowrap<cr>

" switch windows with g+movement
nmap gj <C-W>j
nmap gk <C-W>k
nmap gh <C-W>h
nmap gl <C-W>l

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

" Tab mappings.
map <Leader>tt :tabnew<cr>
map <Leader>te :tabe %%
map <Leader>tc :tabclose<cr>
map <Leader>to :tabonly<cr>
map <Leader>tn :tabnext<cr>
map <Leader>tp :tabprevious<cr>
map <Leader>tf :tabfirst<cr>
map <Leader>tl :tablast<cr>
map <Leader>tm :tabmove
" NERDTree
map <Leader>n :NERDTreeToggle<cr>

" previous/next buffer (for going without tabs)
nmap g[ :bp<cr>
nmap g] :bn<cr>

" ack for project-wide searching (TRAILING WHITESPACE IS INTENTIONAL)
nmap g/ :Ack! 
nmap g* :Ack! -w <C-R><C-W>
nmap gA :AckAdd!
nmap gn :cnext<cr>
nmap gp :cprev<cr>
nmap gc :ccl<cr>

" search and replace the word under the cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
" remove search hilighting
nmap <silent> <Leader>h :silent :nohlsearch<CR>

" rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" clear up trailing white space
nmap <leader>s :%s/\s\+$//<CR>

" full blame for Git and Mercurial
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" align pipe-separated tables for cucumber or textile with g| in visual mode
vmap g\| :Align \|<cr>

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

