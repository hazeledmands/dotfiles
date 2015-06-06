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

# add a new terminfo compiler to allow italics
cat <<-EOF > xterm-256color-italic.terminfo
# A xterm-256color based TERMINFO that adds the escape sequences for italic.
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
EOF
tic xterm-256color-italic.terminfo
rm xterm-256color-italic.terminfo

cat <<-EOF > screen-256color-italic.terminfo
# A screen-256color based TERMINFO that adds the escape sequences for italic.
screen-256color-italic|screen with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=screen-256color,
EOF
tic screen-256color-italic.terminfo
rm screen-256color-italic.terminfo

# osx defaults
echo "Setting up osx defaults..."
source $HOME/.dotfiles/hooks/osx_defaults

# finally, run rcup
RCRC=$HOME/.dotfiles/rcrc rcup
