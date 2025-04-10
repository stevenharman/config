# oh-my-zsh configuration
export ZSH_CUSTOM="$HOME/.zsh/custom"
# Path to oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"
# Look in ~/.zsh/custom/themes/
export ZSH_THEME="smh"

# Source fzf before zsh-navigation-tools b/c we want znt's keybindings for ^R
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# Source iTerm2 shell integration
if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# see: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#update-settings
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gem terraform yarn zsh-navigation-tools stripe)

source $ZSH/oh-my-zsh.sh

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
