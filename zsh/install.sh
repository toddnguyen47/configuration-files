#!/bin/bash

# Execute all completion files in ./themes/
# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dir_of_this_script="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for zsh_theme_file in $dir_of_this_script/themes/*.zsh-theme; do
  cp -v $zsh_theme_file ~/.oh-my-zsh/custom/themes/
done

# Copy all files in zsh-scripts to ~/.oh-my-zsh/custom
for zsh_script in $dir_of_this_script/zsh-scripts/*.zsh; do
  cp -v --no-clobber $zsh_script ~/.oh-my-zsh/custom
done

# Copy functions folder over to ~/.oh-my-zsh
cp -rv --no-clobber functions ~/.oh-my-zsh

