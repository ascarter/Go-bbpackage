#! /bin/sh

gorunner="$(dirname "$0")/../Resources/gorunner"
CTAGS=/Applications/BBEdit.app/Contents/Helpers/ctags
ctags_defs="$(dirname "$0")/../Resources/ctags"

cd $("$gorunner" pwd)
CTAGS_ARGS="--recurse --fields=+a+m+n+S --excmd=number --tag-relative=no"

# Check to see if Go is missing
$CTAGS --list-languages | grep Go > /dev/null
if [ $? == 1 ]
then
	CTAGS_ARGS="--options='$ctags_defs' $CTAGS_ARGS"
fi

$CTAGS $CTAGS_ARGS .

