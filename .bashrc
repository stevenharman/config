# For zsh parity
alias ..="cd .."

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH="$HOME"/Library/Caches/heroku/autocomplete/bash_setup

if [[ -f $HEROKU_AC_BASH_SETUP_PATH ]]; then
  source "$HEROKU_AC_BASH_SETUP_PATH"
else
  CLEAR_LINE='\r\033[K'
  NO_COLOR='\033[0m'
  YELLOW='\033[0;33m'
  printf "${CLEAR_LINE}⚠️${YELLOW}   .bashrc: Missing Heroku CLI Completions. See: https://devcenter.heroku.com/articles/heroku-cli-autocomplete.${NO_COLOR}\n"
fi

if [[ -f "$HOME/.fzf.bash" ]]; then
  source "$HOME/.fzf.bash"
fi
