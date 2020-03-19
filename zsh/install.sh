#!/bin/bash

# Execute all completion files in ./themes/
# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dirOfThisScript="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for zsh_theme_file in $dirOfThisScript/themes/*.zsh-theme; do
  cp -v $zsh_theme_file ~/.oh-my-zsh/custom/themes/
done

