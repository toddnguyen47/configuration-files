#!/bin/bash

# Execute all completion files in ./completions/
# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dirOfThisScript="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for bashfile in $dirOfThisScript/completions/*.bash;
do
  printf "Adding completion: $bashfile\n"
  source "$bashfile"
done
