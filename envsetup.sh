#!/usr/bin/env bash

# Find the top dir of ci-scripts.
DOTFILE_TOP=$(realpath $(dirname $BASH_SOURCE))

# Bash folder.
DOTFILE_BASH="$DOTFILE_TOP/bash"

# Helper folder.
DOTFILE_HELPER="$DOTFILE_TOP/helper"

# Vim folder
DOTFILE_VIM="$DOTFILE_TOP/vim"

# Docker folder
DOTFILE_DOCKER="$DOTFILE_TOP/docker"

# Export variables.
export DOTFILE_TOP
export DOTFILE_BASH
export DOTFILE_HELPER
export DOTFILE_VIM
export DOTFILE_DOCKER

# Include helpers.
. "$DOTFILE_HELPER/msg.sh"
. "$DOTFILE_HELPER/run.sh"
. "$DOTFILE_HELPER/miscutils.sh"
