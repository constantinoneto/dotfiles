#!/bin/sh

# link my configuration files
find ~/.dotfiles/ -maxdepth 1 -name ".*"        \
    ! -path ~/.dotfiles/ ! -path ~/.dotfiles/.git \
      -exec ln -sf {} --target-directory=$HOME \;
