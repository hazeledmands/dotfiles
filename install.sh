#!/usr/bin/env bash

if [ -d $HOME/Projects/dotfiles ] && ! [ -L $HOME/.dotfiles ]; then
  ln -s $HOME/Projects/dotfiles $HOME/.dotfiles
fi

source ./hooks/pre-up

rcup
