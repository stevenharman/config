autoload -U compinit && compinit
autoload colors && colors

bindkey "^[" vi-cmd-mode

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/history.zsh
source ~/.zsh/set_options.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
