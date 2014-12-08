#! /bin/sh

PATH="$(dirname "$0")/../Resources":$PATH
CTAGS=/Applications/BBEdit.app/Contents/Helpers/ctags
CTAGS_ARGS="--recurse --fields=+a+m+n+S --excmd=number --tag-relative=no"
ctags_defs="$(dirname "$0")/../Resources/ctags"

cd $(gorunner pwd)

# Check to see if Go is missing
$CTAGS --list-languages | grep Go > /dev/null
if [ $? == 1 ]
then
	CTAGS_ARGS="--options='$ctags_defs' $CTAGS_ARGS"
fi

$CTAGS $CTAGS_ARGS .

