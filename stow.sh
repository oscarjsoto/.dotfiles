#!/usr/bin/env bash

CONFIGS = "profile git tmux scripts nvim zsh"

stow --adopt $CONFIGS
git restore .
stow bash $CONFIGS
