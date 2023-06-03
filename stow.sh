#!/usr/bin/env bash

stow --adopt bash git tmux
stow --adopt -t /root/ rootBash --ignore=ERR*
git restore .
stow bash git tmux
stow rootBash -t /root/ --ignore=ERR*
