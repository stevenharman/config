# Setup fzf
# ---------
if [[ ! "$PATH" == *"${HOME}/.fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi


if command -v fzf > /dev/null 2>&1; then
  eval "$(fzf --bash)"
else
  echo "fzf is not installed; skipping fzf setup for Bash"
fi
