#!/usr/bin/env bash

stow --adopt bash git
stow --adopt rootBash
git restore .
stow bash git
stow rootBash
