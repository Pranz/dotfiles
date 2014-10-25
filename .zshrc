# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bureau"
export TERM="xterm-256color"
export EDITOR="vim"

plugins=(git archlinux)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.cabal/bin"
export LD_LIBRARY_PATH="/usr/local/lib"

#for vim
stty -ixon
