#!/bin/bash

# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-PROMPT_005fDIRTRIM-226
export PROMPT_DIRTRIM=3 

# Ref: https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# Use an associated array (hash table) for colors
declare -A fg_colors
fg_colors[default]='\[\e[0m\]'
fg_colors[black]='\[\e[0;30m\]'
fg_colors[red]='\[\e[0;31m\]'
fg_colors[green]='\[\e[0;32m\]'
fg_colors[yellow]='\[\e[0;33m\]'
fg_colors[blue]='\[\e[0;34m\]'
fg_colors[magenta]='\[\e[0;35m\]'
fg_colors[cyan]='\[\e[0;36m\]'
fg_colors[white]='\[\e[0;37m\]'

declare -A fg_colors_bold
fg_colors_bold[default]='\[\e[0m\]'
fg_colors_bold[black]='\[\e[1;30m\]'
fg_colors_bold[red]='\[\e[1;31m\]'
fg_colors_bold[green]='\[\e[1;32m\]'
fg_colors_bold[yellow]='\[\e[1;33m\]'
fg_colors_bold[blue]='\[\e[1;34m\]'
fg_colors_bold[magenta]='\[\e[1;35m\]'
fg_colors_bold[cyan]='\[\e[1;36m\]'
fg_colors_bold[white]='\[\e[1;37m\]'

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Ref: https://stackoverflow.com/a/20026992
print_virtualenv() {
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

# Ref: https://stackoverflow.com/a/16715681
PROMPT_COMMAND=__prompt_command # Func to generate PS1 after CMDs

__prompt_command() {
  local EXIT="$?" # This needs to be first
  PS1=""

  local promptChar="↳"
  local failedPromptChar="✘"
  # Check if user is root
  if [[ "$EUID" -eq 0 ]]; then
    promptChar="#"
    failedPromptChar="#"
  fi

  local space=' '
  local newline='\n'

  # Add a beginning newline
  # PS1+="${newline}"

  # Add git branch if the command exists
  # Ref: https://stackoverflow.com/a/677212
  if command -v __git_ps1 &> /dev/null; then
    local git_prompt="$(__git_ps1)"
    # Check if git_prompt length is not 0
    if [ ! -z ${git_prompt} ]; then
      PS1+="${fg_colors_bold[yellow]}${git_prompt}${fg_colors_bold[default]}${space}"
    fi
  fi

  # Add possible virtualenv
  PS1+="$(print_virtualenv)"

  # Add user@hostname
  PS1+="${fg_colors_bold[green]}(\u@\h)${space}"

  # Add directory
  PS1+="${fg_colors_bold[blue]}(\w)${space}"

  # Add time
  PS1+="${fg_colors[default]}(\A)"

  # Add prompt now!
  # If exit code failed
  if [ "${EXIT}" != 0 ]; then
    PS1+="${fg_colors_bold[red]}" # Add red if exit code is non-0
    # Add exit code
    PS1+="${space}[${EXIT}]"
    promptChar="${failedPromptChar}"
  fi
  PS1+="${newline}"
  PS1+="${promptChar}"

  # Reset color for user
  PS1+="${fg_colors[default]}${space}"
}
