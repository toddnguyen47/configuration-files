#!/bin/bash

# Execute all completion files in ./completions/
# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dir_of_this_script="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for bash_file in $dir_of_this_script/completions/*.bash; do
  printf "Adding completion: $bash_file\n"
  source "$bash_file"
done
