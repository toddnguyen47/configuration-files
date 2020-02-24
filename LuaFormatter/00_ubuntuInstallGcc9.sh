#!/bin/bash

# Add Toolchain test builds PPA so `apt` can install gcc-9
addToolchainRepository() {
  # Public Key: 0x60C317803A41BA51845E371A1E9377A2BA9EF27F
  apt-key add ./ubuntu-toolchain.gpg
  # bionic is Ubuntu 18.04's name
  echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main" | tee /etc/apt/sources.list.d/ubuntu-toolchain-r-test-bionic.list
  echo "#deb-src http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main" | tee -a /etc/apt/sources.list.d/ubuntu-toolchain-r-test-bionic.list
  apt-get update
}

installDefaultUbuntuGcc() {
  apt-get -y install build-essential
}

installGccGpp9() {
  apt-get -y install gcc-9 g++-9
}

useGcc9AsDefault() {
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 --slave /usr/bin/g++ g++ /usr/bin/g++-9
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 --slave /usr/bin/g++ g++ /usr/bin/g++-7
  update-alternatives --set gcc /usr/bin/gcc-9
}

endOfScript() {
  printf "*****\n"
  printf "Finished installing gcc-9 and g++-9\n"
}

# Execute functions!
execute() {
  installDefaultUbuntuGcc
  addToolchainRepository
  installGccGpp9
  useGcc9AsDefault
  endOfScript
}

execute

