#!/usr/bin/env bash

stow --adopt bash git tmux bin
git restore .
stow bash git tmux bin
