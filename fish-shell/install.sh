#!/bin/bash

SRC_DIR="functions"
DEST_FISH_PROMPT_DIR="/usr/share/fish/functions"

CUR_FILE="fish_prompt.fish"
# If backup file doesn't exist yet
if [ ! -f "$DEST_FISH_PROMPT_DIR"/"$CUR_FILE".bak ]; then
  sudo cp -v ""$DEST_FISH_PROMPT_DIR"/"$CUR_FILE"" ""$DEST_FISH_PROMPT_DIR"/"$CUR_FILE".bak"
  printf "%s\n" "Orig backed up"
fi

sudo cp -v "$CUR_FILE" "$DEST_FISH_PROMPT_DIR/$CUR_FILE"

# Copy the rest into /usr/share
DEST_DIR="$HOME/.config/fish/functions"
mkdir -p $DEST_DIR

# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dirOfThisScript="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
for fish_file in "$dirOfThisScript/functions/*.fish"; do
  cp -v $fish_file $DEST_DIR
done

