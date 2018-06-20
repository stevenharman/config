# oh-my-zsh configuration
export ZSH_CUSTOM=$HOME/.zsh/custom
# Path to oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="smh"

# Source fzf before zhs-navigation-tools b/c we want znt's keybindings for ^R
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(bundler gem yarn zsh-navigation-tools)

source "$ZSH"/oh-my-zsh.sh

# zsh-navigation-tools configuration, overrides ~/.config/znt
znt_list_border=1

# When using new (>5.2) Zsh version that supports 256 colors in zcurses
#znt_list_themes=( "white/17/0" "10/17/1" "white/24/1" "white/22/0" "white/22/1" "white/25/0" "white/25/1"
#                  "white/59/0" "white/59/1" "white/60/0" "white/60/1" "white/61/0" "white/61/1" "black/65/0"
#                  "black/244/0" )

# When 1, pressing enter when in search mode will not only leave the mode, but
# also do selection and leave n-history
znt_list_instant_select=0

# Search keywords, iterated with F2 or Ctrl-X or Ctrl-/
znt_history_keywords=( "heroku" "WEB_CONCURRENCY" "bin/rails" )

bindkey "^[" vi-cmd-mode
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Customization of tab-completion
source ~/.zsh/completion.zsh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH="$HOME"/Library/Caches/heroku/autocomplete/zsh_setup

if [[ -f $HEROKU_AC_ZSH_SETUP_PATH ]]; then
  source "$HEROKU_AC_ZSH_SETUP_PATH"
else
  CLEAR_LINE='\r\033[K'
  NO_COLOR='\033[0m'
  YELLOW='\033[0;33m'
  printf "${CLEAR_LINE}⚠️${YELLOW}   .zshrc: Missing Heroku CLI Completions. See: https://devcenter.heroku.com/articles/heroku-cli-autocomplete.${NO_COLOR}\n"
fi
