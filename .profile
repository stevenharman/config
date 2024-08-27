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

brew_dir="/usr/local" # On Intel machines Homebrew installs to /usr/local, which is already on the PATH
if [ "$(arch)" = "arm64" ]; then
  # On Apple Silicon machines Homebrew installs to /opt/homebrew, which isn't on the PATH.
  brew_dir="/opt/homebrew"
fi
brew_cmd="${brew_dir}/bin/brew"

if command -v "$brew_cmd" > /dev/null 2>&1; then
  # Export HOMEBREW_* settings
  eval "$($brew_cmd shellenv)"
fi

# On some systems, e.g., macOS 10.15, /usr/local/bin is already at the front of
# PATH by way of `/etc/paths`. On other systems it might not be there. `brew shellenv`
# will add it and `/usr/local/sbin` to the front of PATH. Meaning we might have
# dupes, making PATH searching slower. To normalize all of this, we'll prepend
# them here, and remove any dupes already there.
path_prepend /usr/local/bin

if command -v cargo > /dev/null 2>&1; then
  path_prepend "$HOME/.cargo/bin"
fi

# Initialize "xenv" language managers, if they're installed
if command -v go > /dev/null 2>&1; then
  path_prepend "$(go env GOPATH)/bin"
fi

nodenv_path="${HOME}/.nodenv/bin/nodenv"
if command -v nodenv > /dev/null 2>&1; then
  eval "$(nodenv init -)"
elif [ -f "${nodenv_path}" ]; then
  eval "$(${nodenv_path} init -)"
fi

if command -v yarn > /dev/null 2>&1; then
  yarn_bin="$(yarn global bin)"
  path_append "$yarn_bin"
fi

rbenv_path="${HOME}/.rbenv/bin/rbenv"
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
elif [ -f "${rbenv_path}" ]; then
  eval "$(${rbenv_path} init -)"
fi

# More PATH configuration

mkdir -p "$HOME"/bin
path_append "$HOME"/bin

# Other Customization

if [[ -e "$HOME"/.iterm2_shell_integration.zsh ]]; then
  source "$HOME"/.iterm2_shell_integration.zsh
fi

# Set fzf to use ripgrep for CTRL-T in shell
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Source 1Password CLI config
if [[ -e "$HOME"/.config/op/plugins.sh ]]; then
  source "$HOME"/.config/op/plugins.sh
fi

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
THOR_MERGE="$(git config --get mergetool.Kaleidoscope.cmd)"
export THOR_MERGE

# My aliases
alias be='bundle exec'
alias gvim='mvim -p'
alias mysql_start='mysql.server start'
alias mysql_stop='mysql.server stop'
# These Postgres aliases assume we're using a shared data dir, rather than versioned data dirs
# See output of `brew info postgresql` for more.
alias pg_start='pg_ctl -D ${HOMEBREW_PREFIX}/var/postgres start'
alias pg_stop='pg_ctl -D ${HOMEBREW_PREFIX}/var/postgres stop -s -m fast'
alias redis_start='redis-server ${HOMEBREW_PREFIX}/etc/redis.conf'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

ghpr() {
  # Shamelessly stolen from https://twitter.com/elijahmanor/status/1559525388417503233
  GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

gitdays() {
  git log --author=Steven --reverse --since="$* days ago" --pretty="format:%n%Cgreen%cd%n%n%s%n%b%n---------------------------------------------"
}

# Open a file in Marked.app. Usage: $ marked path/to/file.markdown
marked() {
  open -a Marked\ 2.app "$@"
}
