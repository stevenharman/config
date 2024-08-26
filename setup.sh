#!/usr/bin/env bash

# This file is used to automate setting up dotfiles in a CodeSpace/Coder.com,
# meaning it's run without human intervertion. So, we need to overwrite
# dotfiles to ensure we get the latest.
OVERWRITE_DOTFILES=true rake install
