### ANTIGEN: zsh plugin manager
#   https://github.com/zsh-users/antigen
source ~/.init/antigen.zsh
antigen bundles <<EOBUNDLES
  # really awesome command line prompt
  nojhan/liquidprompt

  # zsh syntax highlighting
  zsh-users/zsh-syntax-highlighting

  # nvm completion
  nvm
EOBUNDLES
antigen apply

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

alias q="exit"
alias git="hub"
alias tmux="tmux -2"

# don't want this stuff in version control (this is probably a security red flag):
if [ -f ~/.sekret ]; then
  source ~/.sekret
fi

export PROJECTS="$HOME/Projects" # where all of my real work lives
export HOMEBREW_CASK_OPTS="--appdir=/Applications" # link my cask apps to ~/Applications
export EDITOR="/usr/local/bin/vim" # for maximum compatibility
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH" # support homebrew binaries
export MANPATH="$BREW_PREFIX/share/man:/usr/share/man:/opt/X11/share/man:$MANPATH"
