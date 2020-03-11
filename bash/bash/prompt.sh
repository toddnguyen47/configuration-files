#!/bin/bash

# Ref: https://stackoverflow.com/a/16715681
PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
  local EXIT="$?" # This needs to be first
  PS1=""

  local promptChar='$'

  local ResetColor='\[\e[0m\]'

  local Red='\[\e[0;31m\]'
  local Green='\[\e[0;32m\]'
  local BoldGreen='\[\e[1;32m\]'
  local BoldYellow='\[\e[1;33m\]'
  local BoldBlue='\[\e[1;34m\]'
  local Purple='\[\e[0;35m\]'
  local Space=' '
  local NewLine='\n'

  # Add user@hostname
  PS1+="${BoldGreen}\u@\h${Space}"

  # Add directory
  PS1+="${BoldBlue}\w${Space}"

  # Add time
  PS1+="${ResetColor}⌚ \A"

  PS1+="${NewLine}"

  # Add prompt now!
  if [ $EXIT != 0 ]; then
    PS1+="${Red}" # Add red if exit code non 0
    promptChar='✘'
  fi
  PS1+="${promptChar}"


  # Reset color for user
  PS1+="${ResetColor}${Space}"
}

