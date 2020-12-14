# Inspired by `robbyrussell` and 'agnoster' theme
# Documentation here: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# Ref for root: https://askubuntu.com/a/707654

_char_failure='✗'
_char_clock='⌚'

_prompt_char() {
  local cur_prompt_char="%(!.#.$)"
  local failed_prompt_char="%(!.#.${_char_failure})"
  printf "%s%s" \
    "%(?.%{$reset_color%}.%{$fg_bold[red]%})" \
    "%(?."$cur_prompt_char"."$failed_prompt_char")"
}

_insert_space() {
  printf " "
}

_insert_exit_code() {
  local failed_char="%{$fg_bold[red]%}[%?]%{$reset_color%}"
  local exit_char="%(?..${failed_char})"
  printf "%s" "${exit_char}"
}

_reset_bg_fg_color() {
  printf "%s" "%{%f%b%k%}"
}

# Ref: https://stackoverflow.com/a/20026992
_print_virtualenv() {
  # Get Virtual Env
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Ref: https://linux.die.net/man/1/bash, look for `${parameter##word}`
    # Strip out the path and just leave the env name
    venv="${VIRTUAL_ENV##*/}"
  else
      # In case you don't have one activated
      venv=''
  fi
  [[ -n "$venv" ]] && printf "%s" "(${venv}) "
}

_current_directory() {
  printf "%s[ %s ]" \
    "%{$fg_bold[cyan]%}" \
    "%~"
}

_user_name() {
  printf "%s[%s]" \
    "%{$fg_bold[yellow]%}" \
    "%n"
}

_current_time() {
  printf "%s${_char_clock} %s" \
    %{$reset_color%} \
    "%T"
}

build_prompt() {
  _reset_bg_fg_color
  _print_virtualenv
  _current_directory
  _insert_space
  _user_name
  _insert_space
  _current_time
}

# Reset background and foreground before building a prompt
# NEED to use single quotes to preserve the literal value of each character!
# Ref: https://stackoverflow.com/a/6697781
PROMPT='$(git_prompt_info)$(build_prompt) $(_insert_exit_code)
$(_prompt_char)%{$reset_color%} '

# Reset RPROMPT
RPROMPT=''

# These are copied from robbyrussell's theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[ git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}${_char_failure}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
