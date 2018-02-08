# For zsh parity
alias ..="cd .."

# heroku autocomplete setup
CLI_ENGINE_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/completions/bash_setup

if [[ -f $CLI_ENGINE_AC_BASH_SETUP_PATH ]]; then
  source $CLI_ENGINE_AC_BASH_SETUP_PATH
else
  CLEAR_LINE='\r\033[K'
  NO_COLOR='\033[0m'
  YELLOW='\033[0;33m'
  printf "${CLEAR_LINE}⚠️${YELLOW}   .bashrc: Missing Heroku CLI Completions. See: https://devcenter.heroku.com/articles/heroku-cli-autocomplete.${NO_COLOR}\n"
fi
