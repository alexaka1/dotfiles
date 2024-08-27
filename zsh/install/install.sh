#!/usr/bin/env bash

cat zprofile >> $HOME/.zprofile
cat zshenv >> $HOME/.zshenv
cat zshrc >> $HOME/.zshrc
source $HOME/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source $HOME/.zshrc