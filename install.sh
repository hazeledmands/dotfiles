#!/usr/bin/env bash

if ! which -s brew; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

if [ -d $HOME/Projects/dotfiles ] && ! [ -L $HOME/.dotfiles ]; then
  ln -s $HOME/Projects/dotfiles $HOME/.dotfiles
fi

source ./hooks/pre-up

RCRC=$HOME/.dotfiles/rcrc rcup
