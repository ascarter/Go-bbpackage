#!/bin/sh

while [[ $# > 1 ]]; do
	OPT="$1"
	shift
	
	case $OPT in
		-pkg|--pkg)
			PKG=$1
			shift
			;;
	esac
done

if [ -n "$PKG" ]; then
	PATH="$(dirname "$0")/../Resources":$PATH
	gorunner go doc "$PKG" 2>&1 | bbedit --new-window --clean --pipe-title "go doc $PKG" +1
fi
