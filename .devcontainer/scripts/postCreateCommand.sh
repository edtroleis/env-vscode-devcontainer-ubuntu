#!/bin/bash

set -ex

SCRIPTS_DIR=".devcontainer/scripts"
MOUNT_HOME_DIR="/host-home-folder"

# printf "Setting git config...\n"
# git config --global http.ssVerify false
# git config --global http.sslBackend "openssl"

# printf "Copying ssh keys...\n"
# cp -r $SCRIPTS_DIR/.ssh $HOME
# chmode -R 400 $HOME/.ssh

# printf "Configuring alias...\n"
# cp $PWD/$SCRIPTS_DIR/bash_aliases ~/.bash_aliases
# source ~/.bash_aliases