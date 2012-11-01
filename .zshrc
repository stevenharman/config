# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="smh"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby rails rails3 node npm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

bindkey "^[" vi-cmd-mode
bindkey '^R' history-incremental-search-backward
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

source ~/.zsh/exports.zsh
# source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
# source local exports
[[ -r ~/.zlocal ]] && source ~/.zlocal

# get around current directory as "~rvm_rvmrc_cwd" weirdness
unsetopt auto_name_dirs

