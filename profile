BREW_PREFIX=`brew --prefix`

export PROJECTS="/Users/me/Projects" # where all of my real work lives
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # link my cask apps to ~/Applications
export EDITOR="/usr/local/bin/vim" # for maximum compatibility
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH" # support homebrew binaries

alias q="exit"
alias git="hub"
alias tmux="tmux -2"

# bash completion for all installed homebrew binaries
source $BREW_PREFIX/Library/Contributions/brew_bash_completion.sh
for completion_file in $BREW_PREFIX/etc/bash_completion.d/*
do
  source $completion_file
done

# don't want this stuff in version control:
if [ -f ~/.sekret ]; then
  source ~/.sekret
fi

# nvm
source $(brew --prefix nvm)/nvm.sh
