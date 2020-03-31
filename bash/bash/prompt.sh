#!/bin/bash

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

# Ref: https://stackoverflow.com/a/16715681
PROMPT_COMMAND=__prompt_command # Func to generate PS1 after CMDs

__prompt_command() {
  local EXIT="$?" # This needs to be first
  PS1=""

  local promptChar="$"
  local failedPromptChar="[${EXIT}]"
  # Check if user is root
  if [[ "$EUID" -eq 0 ]]; then
    promptChar="#"
    failedPromptChar="#"
  fi

  local space=' '
  local newline='\n'

  # Add user@hostname
  PS1+="${fg_colors_bold[green]}\u@\h${space}"

  # Add directory
  PS1+="${fg_colors_bold[blue]}\w${space}"

  # Add time
  PS1+="${fg_colors[default]}⌚ \A"

  PS1+="${newline}"

  # Add prompt now!
  if [ "${EXIT}" != 0 ]; then
    PS1+="${fg_colors_bold[red]}" # Add red if exit code non 0
    promptChar="${failedPromptChar}"
  fi
  PS1+="${promptChar}"


  # Reset color for user
  PS1+="${fg_colors[default]}${space}"
}

