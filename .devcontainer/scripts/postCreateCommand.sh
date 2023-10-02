#!/bin/bash

# set -ex

SCRIPTS_DIR=".devcontainer/scripts"
MOUNT_HOME_DIR="/host-home-folder"

# printf "Setting git config...\n"
# git config --global http.ssVerify false
# git config --global http.sslBackend "openssl"

# printf "Copying ssh keys...\n"
# cp -r $SCRIPTS_DIR/.ssh $HOME
# chmod 600 ~/.ssh/*

printf "Configuring bash...\n"
cat ${SCRIPTS_DIR}/bash/bashrc >> ~/.bashrc
cp ${SCRIPTS_DIR}/bash/bash_aliases ${HOME}/.bash_aliases
source ~/.bashrc
source ~/.bash_aliases
