fzf_bin="${HOME}/.fzf/bin"

if command -v fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
elif [ -f "${fzf_bin}/fzf" ]; then
  path_append "${fzf_bin}"
  source <("${fzf_bin}/fzf" --zsh)
else
  echo "fzf is not installed; skipping fzf setup for Zshell"
fi
