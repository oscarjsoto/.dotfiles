#!/usr/bin/env bash

param="profile git tmux scripts nvim zsh"

stow --adopt $param
git restore .
stow bash $param
