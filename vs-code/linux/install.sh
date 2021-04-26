#!/bin/bash

_settings_keybindings_folder="$HOME/.config/Code/User"
_extensions_folder="$HOME/.vscode/extensions"

# Ref: https://stackoverflow.com/a/246128, in the comments
_script_dir="$(dirname "$(readlink -f "$0")")"

# Ref: https://stackoverflow.com/a/226724
printf "Overwrite files in '%s' and '%s'? (Y/n)\n" ${_settings_keybindings_folder} ${_extensions_folder}
select yn in "Yes" "No"; do
  case $yn in
    Yes ) break;;
    No ) exit;;
  esac
done

_do_work() {
  pushd ${_script_dir} > /dev/null
  mkdir -p "${_extensions_folder}"
  mkdir -p "${_settings_keybindings_folder}"
  cp -v "keybindings.json" "${_settings_keybindings_folder}/keybindings.json"
  pushd .. > /dev/null
  cp -v "settings.json" "${_settings_keybindings_folder}/settings.json"

  popd > /dev/null
  popd > /dev/null
}

_run() {
  # Ref: https://unix.stackexchange.com/a/314370
  start_time="$(date -u +%s.%N)"

  _do_work

  # Get elapsed time
  end_time="$(date -u +%s.%N)"
  elapsed="$(bc <<< "$end_time-$start_time")"
  #echo "Total of $elapsed seconds elapsed for process"
  printf "Total of %.2f seconds elapsed.\n" ${elapsed}
}

_run
