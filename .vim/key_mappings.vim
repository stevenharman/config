" get out of insert mode with cmd-i
  imap <D-i> <Esc>

" redo with U
  nmap U :redo<cr>

" easy wrap toggling
  nmap <Leader>w :set wrap<cr>
  nmap <Leader>W :set nowrap<cr>

" switch windows with g+movement
  nmap gj j
  nmap gk k
  nmap gh h
  nmap gl l

" swap windows
  nmap gS 

" close all other windows (in the current tab)
  nmap gW :only<cr>

" Tab mappings.
  map <Leader>tt :tabnew<cr>
  map <Leader>te :tabedit
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

" ack for project-wide searching
  nmap g/ :LAck 
  nmap g* :LAck <C-R><C-W> 
  nmap ga :LAckAdd 
  nmap gn :lnext<cr>
  nmap gp :lprev<cr>

" search and replace the word under the cursor
  nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
" remove search hilighting
  nmap <silent> <Leader>h :silent :nohlsearch<CR>

" rapidly toggle `set list`
  nmap <leader>l :set list!<CR>

" full blame for Git and Mercurial
  vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 
  vmap <Leader>h :<C-U>!hg blame -fu <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" shortcuts for frequenly used files
"  nmap gs :e db/schema.rb<cr>
"  nmap gr :e config/routes.rb<cr>

" align pipe-separated tables for cucumber or textile with g| in visual mode
	vmap g\| :Align \|<cr>

" insert blank lines without going into insert mode
  nmap go o<esc>
  nmap gO O<esc>

" open the source in a browser for distribution or copying as RTF
  nmap gH :OpenHtml<cr>

" Bubble single lines (uses unimpaired.vim)
  nmap <C-Up> [e
  nmap <C-Down> ]e
" Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv

" scroll up/down one line at a time
  nmap <Up> 
  nmap <Down> 
" scroll up/down 3 lines at a time
  nnoremap <C-y> 3<C-y>
  nnoremap <C-e> 3<C-e>

" scroll left/right
  nmap <Left> zh
  nmap <Right> zl

" Fuzzy Finder - \t to launch; \b just for buffers; cmd-enter to open selected file in new tab
  "nmap <Leader>t :FuzzyFinderTextMate<cr> 
  "nmap <Leader>b :FuzzyFinderBuffer<cr> 
  "nmap <Leader>f :ruby finder.rescan!<cr>
  

