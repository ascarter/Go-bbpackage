#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH

CTAGS=/Applications/BBEdit.app/Contents/Helpers/ctags
CTAGS_ARGS="--recurse --fields=+a+m+n+S --excmd=number --tag-relative=no"
CTAGS_DEFS="$(dirname "$0")/../Resources/ctags"
GOTAGS=$(gorunner which gotags)

# TODO: test to see if git rev-parse failed or not and fall back to doc path
PROJ_DIR=$(gorunner git rev-parse --show-toplevel)
TAGFILE="${PROJ_DIR}/tags"

# Prefer gotags if it is installed
if [ -z "${GOTAGS}" ]; then
	# Use ctags

	# Check to see if Go is missing
	$CTAGS --list-languages | grep Go > /dev/null
	if [ $? == 1 ]
	then
		CTAGS_ARGS="--options='$CTAGS_DEFS' $CTAGS_ARGS"
	fi

	$CTAGS $CTAGS_ARGS -f="$TAGFILE" "$PROJ_DIR"
else
	# Use gotags
	${GOTAGS} -f="$TAGFILE" -R "$PROJ_DIR"
fi
