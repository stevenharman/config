
ZSH_THEME_GIT_PROMPT_PREFIX="|%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function smh_rbenv_prompt_info {
  local current_ruby=$(rbenv version-name)
  echo "%{$fg[magenta]%}$current_ruby%{$reset_color%}"
}

function smh_nodenv_prompt_info {
  local current_node=$(nodenv version-name)
  echo "%{$fg[green]%}$current_node%{$reset_color%}"
}

function prompt_char {
  if [ $UID -eq 0 ]; then echo "%{$fg[red]%}☠%{$reset_color%}"; else echo $; fi
}

# Save a smiley to a local variable if the last command exited with success.
local smiley="%(?,%{$fg[green]%}◎%{$reset_color%},%{$fg[red]%}◉%{$reset_color%})"

PROMPT='
%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%} [$(smh_rbenv_prompt_info)|$(smh_nodenv_prompt_info)$(git_prompt_info)]
%_${smiley} $(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

