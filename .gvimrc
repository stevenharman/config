" Vim graphical configuration.
  set guifont=Inconsolata:h18,Monaco:h18,Consolas:h12,Lucida_Console:h9
	set antialias                     " MacVim: smooth fonts.
	set encoding=utf-8                " Use UTF-8 everywhere.
	set guioptions-=T                 " Hide toolbar.
	set guioptions=e
  set guioptions-=m
"  set lines=33 columns=100					" Window dimensions.
  if exists('+fuoptions')						" Fullscreen options for MacVim.
  	set fuoptions=maxvert,maxhorz,background:Normal
  endif
	
  colors twilight2									" Prettier colors than terminal mode.
