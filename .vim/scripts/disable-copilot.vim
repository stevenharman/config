" disable-copilot.vim — disable GitHub Copilot for the current buffer.
"
" WHY THIS EXISTS
"   I want Copilot in personal projects but NOT in work/internal repos (e.g.
"   anything under ~/code/docsend-internal or ~/code/dropbox-internal), so no
"   work code is ever sent to Copilot.
"
" WHY BUFFER-LOCAL (b:copilot_enabled) RATHER THAN GLOBAL
"   .vimrc sources a repo's .git/localvimrc per BUFFER (see the repoLocalVimrc
"   autocmd there), resolving the git dir from each buffer's own file. Setting
"   b:copilot_enabled = v:false disables Copilot for just this buffer, so a work
"   buffer and a personal buffer can coexist in one Vim session. Copilot's
"   buffer gate (s:BufferDisabled) honors b:copilot_enabled, so a disabled
"   buffer is never attached — its contents are never sent to Copilot.
"
"   (b:copilot_enabled, not g:copilot_enabled: the global flag only suppresses
"   suggestions and is not consulted by the attach gate.)
"
" HOW TO USE
"   Do NOT source this from the tracked .vimrc — that would disable Copilot
"   everywhere. Instead, per work repo, drop an UNTRACKED .git/localvimrc
"   containing:
"
"       " ~/code/<work-repo>/.git/localvimrc
"       source $HOME/.vim/scripts/disable-copilot.vim
"
"   .vimrc discovers and sources that file for every buffer belonging to the
"   repo, regardless of where Vim was launched or how the file was opened.

let b:copilot_enabled = v:false
