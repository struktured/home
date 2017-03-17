#!/usr/bin/env bash

EDITOR=nvim

if [ -n "$DISPLAY" ]; then
   EDITOR=nvim-qt
else
   EDITOR=nvim
fi

if [ -z "$*" ]; then
   ARGS=+CtrlP
else
   ARGS=$*
fi

$EDITOR $ARGS

