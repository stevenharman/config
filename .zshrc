autoload -U compinit && compinit
autoload colors && colors

bindkey "^[" vi-cmd-mode

source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/history.zsh
source ~/.zsh/set_options.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#export PATH=$PATH:~/code/git-achievements
#alias git="git-achievements"
