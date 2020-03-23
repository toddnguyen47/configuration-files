#!/bin/bash

# Set up directories
mkdir -p ~/.bash/
mkdir -p ~/.bash/completions

# Copy files over, no ovewriting
cp -rv --no-clobber bash/* ~/.bash/
cp -v --no-clobber addBashRc.sh ~/.addBashRc.sh

# Always overwrite prompt.sh though
cp -v bash/prompt.sh ~/.bash/prompt.sh

# Add to ~/.bashrc if this line is not in there
# Ref: https://stackoverflow.com/a/4749368
addBashRcCommand="test -f ~/.addBashRc.sh && source ~/.addBashRc.sh"
bashrcFile="$HOME/.bashrc"
# `grep` will set the exit status `$?` to 0 if found, 1 if not found
grep -Fxq "$addBashRcCommand" "$bashrcFile"
if [[ $? -ne 0 ]] ; then
  printf "\n%s\n\n" "$addBashRcCommand" | tee -a "$bashrcFile"
fi

printf "Installation finished!\n"
printf "Restarting bash shell...\n"
printf "%s\n" "-----"
exec bash

