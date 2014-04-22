#!/user/bin/env bash

BREW_PREFIX=`brew --prefix`

alias q="exit"
alias git="hub"
alias tmux="tmux -2"

# bash completion for all installed homebrew binaries
if [ -f $BREW_PREFIX/etc/bash_completion ]; then
  source $BREW_PREFIX/etc/bash_completion
fi

# nvm
source $(brew --prefix nvm)/nvm.sh


# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# don't want this stuff in version control (this is probably a security red flag):
if [ -f ~/.sekret ]; then
  source ~/.sekret
fi

export PROJECTS="$HOME/Projects" # where all of my real work lives
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # link my cask apps to ~/Applications
export EDITOR="/usr/local/bin/vim" # for maximum compatibility
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH" # support homebrew binaries
export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
