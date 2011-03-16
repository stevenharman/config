" get out of insert mode with cmd-i
  imap <D-i> <Esc>

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

" swap windows
  nmap gS <C-W><C-R>

" close all other windows (in the current tab)
  nmap gW :only<cr>

" Opens an edit command with the path of the currently edited file filled in
  cnoremap %% <C-R>=expand("%:p:h").'/'<cr>
  map <Leader>e :edit %%
  map <Leader>v :view %%
  map <leader>mv :call RenameFile()<cr>

" Remap tab key to do autocomletion or indentation depending on the context
  inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <s-tab> <c-n>

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
  nmap ga :AckAdd! 
  nmap gn :cnext<cr>
  nmap gp :cprev<cr>
  nmap gq :ccl<cr>

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
  nmap <Up> <C-Y>
  nmap <Down> <C-E>
" scroll up/down 3 lines at a time
  nnoremap <C-Y> 3<C-Y>
  nnoremap <C-E> 3<C-E>

" scroll left/right
  nmap <Left> zh
  nmap <Right> zl

" Fuzzy Finder - \t to launch; \b just for buffers; cmd-enter to open selected file in new tab
  "nmap <Leader>t :FuzzyFinderTextMate<cr> 
  "nmap <Leader>b :FuzzyFinderBuffer<cr> 
  "nmap <Leader>f :ruby finder.rescan!<cr>
  

