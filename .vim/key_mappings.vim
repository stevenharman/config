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
  map <leader>tt :tabnew<cr>
  map <leader>te :tabedit
  map <leader>tc :tabclose<cr>
  map <leader>to :tabonly<cr>
  map <leader>tn :tabnext<cr>
  map <leader>tp :tabprevious<cr>
  map <leader>tf :tabfirst<cr>
  map <leader>tl :tablast<cr>
  map <leader>tm :tabmove
" NERDTree
	map <leader>n :NERDTreeToggle<cr>

" previous/next buffer (for going without tabs)
  nmap g[ :bp<cr>
  nmap g] :bn<cr>

" ack for project-wide searching
  nmap g/ :LAck 
  nmap g* :LAck <C-R><C-W> 
  nmap ga :LAckAdd 
  nmap gn :lnext<cr>
  nmap gp :lprev<cr>

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

" scroll up/down one line at a time
  nmap <Up> 
  nmap <Down> 

" scroll left/right
  nmap <Left> zh
  nmap <Right> zl

" Fuzzy Finder - \t to launch; \b just for buffers; cmd-enter to open selected file in new tab
  "nmap <Leader>t :FuzzyFinderTextMate<cr> 
  "nmap <Leader>b :FuzzyFinderBuffer<cr> 
  "nmap <Leader>f :ruby finder.rescan!<cr>
  

