#!/usr/bin/env bash

# download homebrew
if ! which -s brew; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# create dotfiles directory
if [ -d $HOME/Projects/dotfiles ] && ! [ -L $HOME/.dotfiles ]; then
  ln -s $HOME/Projects/dotfiles $HOME/.dotfiles
fi

# run pre-up
source $HOME/.dotfiles/hooks/pre-up

# osx defaults
echo "Setting up osx defaults..."
source $HOME/.dotfiles/hooks/osx_defaults

# finally, run rcup
RCRC=$HOME/.dotfiles/rcrc rcup
