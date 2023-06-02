#!/usr/bin/env bash

stow --adopt bash git
stow --adopt rootBash --ignore=ERR*
git restore .
stow bash git
stow rootBash --ignore=ERR*
