#!/usr/bin/env bash

stow --adopt -t /root/ rootBash --ignore=ERR*
git restore .
stow rootBash -t /root/ --ignore=ERR*
