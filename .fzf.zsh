# Setup fzf
# ---------
if [[ ! "$PATH" == *"${HOME}/.fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

if command -v fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo "fzf is not installed; skipping fzf setup for Zshell"
fi
