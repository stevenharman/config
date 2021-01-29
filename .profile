path_append() {
  new_path=$1

  if [ -d "$new_path" ] && [[ ":$PATH:" != *":$new_path:"* ]]; then
    PATH="${PATH:+"$PATH:"}$new_path"
  fi
}

path_prepend() {
  new_path=$1

  if [ -d "$new_path" ]; then
    PATH=${PATH//":$new_path:"/:} #delete all instances in the middle
    PATH=${PATH/%":$new_path"/} #delete any instance at the end
    PATH=${PATH/#"$new_path:"/} #delete any instance at the beginning
    PATH="$new_path${PATH:+":$PATH"}" #prepend $new_path or if $PATH is empty set to $new_path
  fi
}

# Export HOMEBREW_* settings
eval "$(brew shellenv)"

# On some systems, e.g., macOS 10.15, /usr/local/bin is already at the front of
# PATH by way of `/etc/paths`. On other systemsit might not be there. `brew
# shellenv` will add it and `/usr/local/sbin` to the front of PATH. Meaning we
# might have dupes, making PATH searhcing slower. To normalize all of this,
# we'll prepend them here, and remove any dupes already there.
path_prepend /usr/local/bin

# Initialize "xenv" language managers, if they're installed
if command -v go > /dev/null 2>&1; then
  path_prepend "$HOME/go/bin"
fi

if command -v nodenv > /dev/null 2>&1; then
  eval "$(nodenv init -)"

  if command -v yarn > /dev/null 2>&1; then
    yarn_bin="$(yarn global bin)"
    path_append "$yarn_bin"
  fi
fi

if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
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

# Set fzf to use ripgrep for CTRL-T in shell
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# source local config
if [[ -r "$HOME"/.profile.local ]]; then
  source "$HOME"/.profile.local
fi

# Editor registration for git, etc...
export CDPATH=:"$HOME"/code
export CLICOLOR=1
export EDITOR="vim"
export GEM_OPEN_EDITOR="vim"
export LC_CTYPE="en_US.UTF-8"
export PGOPTIONS='-c client_min_messages=WARNING'
export RIPGREP_CONFIG_PATH="$HOME"/.ripgreprc

# Configure Krypton for Git Commit Signing
export GPG_TTY=$(tty)

# My aliases
alias b='cd -'
alias restart='touch tmp/restart.txt'
alias be='bundle exec'
alias gvim='mvim -p'
alias mysql_start='mysql.server start'
alias mysql_stop='mysql.server stop'
alias pg_start='pg_ctl -D /usr/local/var/postgres start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias redis_start='redis-server /usr/local/etc/redis.conf'

gitdays() {
  git log --author=Steven --reverse --since="$* days ago" --pretty="format:%n%Cgreen%cd%n%n%s%n%b%n---------------------------------------------"
}

# Open a file in Marked.app. Usage: $ marked path/to/file.markdown
marked() {
  open -a Marked\ 2.app "$@"
}
