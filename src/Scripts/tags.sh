#!/bin/sh

PATH="$(dirname "$0")/../Resources":$PATH

cd $(gorunner pwd)

GOTAGS=$(gorunner which gotags)

# Prefer gotags if it is installed
if [ -z "${GOTAGS}" ]; then
	# Use ctags
	CTAGS=/Applications/BBEdit.app/Contents/Helpers/ctags
	CTAGS_ARGS="--recurse --fields=+a+m+n+S --excmd=number --tag-relative=no"
	CTAGS_DEFS="$(dirname "$0")/../Resources/ctags"

	# Check to see if Go is missing
	$CTAGS --list-languages | grep Go > /dev/null
	if [ $? == 1 ]
	then
		CTAGS_ARGS="--options='$CTAGS_DEFS' $CTAGS_ARGS"
	fi

	$CTAGS $CTAGS_ARGS .
else
	# Use gotags
	${GOTAGS} -f="tags" -R .
fi
