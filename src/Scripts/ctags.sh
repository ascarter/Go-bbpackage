#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH

CTAGS_ARGS="--recurse --fields=+a+m+n+S --extra=+p+q+r --excmd=number --tag-relative=no --sort=no --exclude=.git"
PROJ_DIR=$(gorunner git rev-parse --show-toplevel)
TAGFILE="${PROJ_DIR}/tags"

ctags ${CTAGS_ARGS} -f "$TAGFILE" "$PROJ_DIR"
