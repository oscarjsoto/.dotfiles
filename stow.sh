#!/usr/bin/env bash

stow --adopt bash git tmux bin nvim zsh
git restore .
stow bash git tmux bin nvim zsh
