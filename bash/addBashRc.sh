#!/bin/bash

printf "Adding Todd's scripts...\n"
printf "Proxy settings are set at /etc/profile.d/proxy-settings.sh\n"

# Set up ~/.bash directory
mkdir -p ~/.bash/
mkdir -p ~/.bash/completions

# Run all scripts in ~/.bash directory
# Ref: https://stackoverflow.com/a/10523501
for file in ~/.bash/*.sh
do
  printf "sourcing $file\n"
  source "$file"
done

printf "%s\n" "Done!"

