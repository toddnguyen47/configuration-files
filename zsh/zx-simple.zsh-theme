# Inspired by `robbyrussell` and 'agnoster' theme
# Documentation here: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# Ref for root: https://askubuntu.com/a/707654

reset_color_func() {
  printf "$reset_color"
}

echo_newline() {
  echo ""
}

current_directory() {
  printf "$fg_bold[cyan]$(pwd)$(reset_color_func) "
}

current_user() {
  printf "$fg[green][$USER]$(reset_color_func) "
}

current_time() {
  printf "[$(date +%H:%M)] "
}


prompt_char() {
  printf "↳ "
}

exit_status() {
  local last_command_exit_status=$?
  if [[ $last_command_exit_status -ne 0 ]]; then
    printf "$fg_bold[red][%s ↵]" $last_command_exit_status
    reset_color_func
    printf " "
  fi
}

build_prompt() {
  exit_status
  current_directory
  current_user
  current_time
}


# Reset background and foreground before building a prompt
PROMPT='%{%f%b%k%}$(build_prompt)
$(git_prompt_info)$(prompt_char)'

# These are copied from robbyrussell's theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
