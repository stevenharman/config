fzf_bin_dir="${HOME}/.fzf" # On Intel machines Homebrew installs fzf to $HOME
fzf_opt_dir="${fzf_bin_dir}"
if [ "$(arch)" = "arm64" ]; then
  # On Apple Silicone machines Homebrew installs fzf elsewhere
  fzf_bin_dir="/opt/homebrew/bin/fzf"
  fzf_opt_dir="/opt/homebrew/opt/fzf"
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *"${fzf_bin_dir}/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}${fzf_bin_dir}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${fzf_opt_dir}/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "${fzf_opt_dir}/shell/key-bindings.bash"
