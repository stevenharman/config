# Initialize "xenv" language managers, if they're installed
if command -v nodenv &>/dev/null; then
  . <(nodenv init -)

  if command -v yarn &> /dev/null; then
    export PATH="$(yarn global bin):$PATH"
  fi
fi

if command -v rbenv &>/dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  . <(rbenv init -)
fi

# More PATH configuration

# Shell-specific settings
if [[ "$SHELL" == *zsh ]]; then
  # Nothing to see here
  true
elif [[ "$SHELL" == *bash ]]; then
  ### stickier .bash_history
  shopt -s histappend

  export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:w:* --help"
fi

# Other Customization

if [[ -e "$HOME"/.iterm2_shell_integration.zsh ]]; then
  source "$HOME"/.iterm2_shell_integration.zsh
fi

# source local config
[[ -r ~/.zlocal ]] && source ~/.zlocal

## Editor registration for git, etc...
export CDPATH=:~/code
export CLICOLOR=1
export EDITOR="vim"
export GEM_OPEN_EDITOR="vim"
export LC_CTYPE="en_US.UTF-8"
export PGOPTIONS='-c client_min_messages=WARNING'

# My aliases
alias b='cd -'
alias restart='touch tmp/restart.txt'
alias be='bundle exec'
alias gvim='mvim -p'
alias mysql_start='mysql.server start'
alias mysql_stop='mysql.server stop'
alias pg_start='pg_ctl -D ~/.pgdata -l ~/.pgdata/psql.log start'
alias pg_stop='pg_ctl -D ~/.pgdata stop -s -m fast'
alias redis_start='redis-server /usr/local/etc/redis.conf'

function gitdays {
  git log --author=Steven --reverse --since="$@ days ago" --pretty="format:%n%Cgreen%cd%n%n%s%n%b%n---------------------------------------------"
}

# Open a file in Marked.app. Usage: $ marked path/to/file.markdown
function marked {
  open -a Marked\ 2.app $@
}
