#!/bin/bash

cur_wd=$PWD
homeDir=$HOME
installDirectory=$homeDir/opt/LuaFormatter

# Ref: https://stackoverflow.com/a/59839
clone_if_directory_does_not_exist() {
  if [ ! -d "./LuaFormatter" ]; then
    if [ ! -L "./LuaFormatter" ]; then
      git clone --recurse-submodules https://github.com/Koihik/LuaFormatter.git
    fi
  fi
}

generate_settings_json() {
  cd $cur_wd
  python3 01_generate_config.py $installDirectory
}

printf "Installing to %s\n" $installDirectory
printf "***** \n"
clone_if_directory_does_not_exist
cd LuaFormatter
mkdir -p $installDirectory
cmake -DCMAKE_INSTALL_PREFIX=$installDirectory .
make
make install
generate_settings_json


printf "***** \n"
printf "All done!\n"
