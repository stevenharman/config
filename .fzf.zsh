# Setup fzf
# ---------
if [[ ! "$PATH" == *"${HOME}/.fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

eval "$(fzf --zsh)"
