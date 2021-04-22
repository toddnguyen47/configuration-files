#!/bin/bash

# Execute all completion files in ./completions/
# Ref: https://stackoverflow.com/a/1482133
# Ref: https://stackoverflow.com/a/11676016
dir_of_this_script="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

for function_file in $dir_of_this_script/functions/*; do
  printf "Adding function: $function_file\n"
  source "$function_file"
done
