#!/usr/bin/env bash

stow --adopt bash git zsh

git restore .
stow bash git zsh
