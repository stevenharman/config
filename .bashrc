# For zsh parity
alias ..="cd .."

### stickier .bash_history
shopt -s histappend
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:w:* --help"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH="$HOME"/Library/Caches/heroku/autocomplete/bash_setup

if [[ -f "$HEROKU_AC_BASH_SETUP_PATH" ]]; then
  source "$HEROKU_AC_BASH_SETUP_PATH"
else
  CLEAR_LINE='\r\033[K'
  NO_COLOR='\033[0m'
  YELLOW='\033[0;33m'
  printf "${CLEAR_LINE}⚠️${YELLOW}   .bashrc: Missing Heroku CLI Completions. See: https://devcenter.heroku.com/articles/heroku-cli-autocomplete.${NO_COLOR}\n"
fi

# `rbenv init` will forceably put itself in this file, unless this file already
# contains the string "rbenv init." And now it does. Twice. 😏

# Source iTerm2 shell integration
if [[ -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
  source "$HOME/.iterm2_shell_integration.bash"
fi

# Source our .profile which does a lot of path and tooling initialization. Yes,
# it's not actually meant for Bash, but I took care not to use any zsh-specific
# functionality, so it works for both!
source "${HOME}/.profile"

if [[ -f "$HOME/.fzf.bash" ]]; then
  source "$HOME/.fzf.bash"
fi
