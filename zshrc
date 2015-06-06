### ANTIGEN: zsh plugin manager
#   https://github.com/zsh-users/antigen
source ~/.init/antigen.zsh
antigen bundles <<EOBUNDLES
  nojhan/liquidprompt
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  nvm
  brew
  brew-cask
  gitfast
  github
  heroku
  demands/mx --loc=bin

  # text objects
  hchbaw/opp.zsh
EOBUNDLES
antigen apply

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# zsh history substring search
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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
