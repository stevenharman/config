fzf_bin="${HOME}/.fzf/bin"

if command -v fzf > /dev/null 2>&1; then
  eval "$(fzf --bash)"
elif [ -f "${fzf_bin}/fzf" ]; then
  path_append "${fzf_bin}"
  eval "$("${fzf_bin}/fzf" --bash)"
else
  echo "fzf is not installed; skipping fzf setup for Bash"
fi
