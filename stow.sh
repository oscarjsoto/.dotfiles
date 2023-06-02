#!/usr/bin/env bash

stow --adopt bash git
stow --adopt -t /root/ rootBash --ignore=ERR*
git restore .
stow bash git
stow rootBash -t /root/ --ignore=ERR*
